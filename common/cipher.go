// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package common

import (
	"encoding/base64"
	"fmt"
	"github.com/apid/apid-core/cipher"
	"io/ioutil"
	"net/http"
	"regexp"
	"strings"
	"sync"
	"time"
)

const RegEncrypted = `^\{[0-9A-Za-z]+/[0-9A-Za-z]+/[0-9A-Za-z]+\}.`
const retrieveEncryptKeyPath = "/encryptionkey"
const EncryptAes = "AES"
const retrieveKeyRetryInterval = time.Duration(5 * time.Second)
const retrieveKeyTimeout = time.Duration(5 * time.Minute)
const parameterOrganization = "organization"
const configBearerToken = "apigeesync_bearer_token"

var RegexpEncrypted = regexp.MustCompile(RegEncrypted)

func CreateCipherManager(client *http.Client, serverUrlBase string) *KmsCipherManager {
	return &KmsCipherManager{
		serverUrlBase: serverUrlBase,
		key:           make(map[string][]byte),
		aes:           make(map[string]*cipher.AesCipher),
		mutex:         &sync.RWMutex{},
		client:        client,
		interval:      retrieveKeyRetryInterval,
		timeout:       retrieveKeyTimeout,
	}
}

type KmsCipherManager struct {
	serverUrlBase string
	// org-level key map {organization: key}
	key map[string][]byte
	// org-level AesCipher map {organization: AesCipher}
	aes      map[string]*cipher.AesCipher
	mutex    *sync.RWMutex
	client   *http.Client
	interval time.Duration
	timeout  time.Duration
}

func (c *KmsCipherManager) AddOrgs(orgs []string) {
	for _, org := range orgs {
		go c.startRetrieve(org, c.interval, c.timeout)
	}
}

func (c *KmsCipherManager) startRetrieve(org string, interval time.Duration, timeout time.Duration) {

	if err := c.retrieveKey(org); err != nil {
		log.Error(err)
	} else {
		return
	}
	ticker := time.NewTicker(interval)
	for {
		select {
		case <-time.After(timeout):
			log.Error("timeout when retrieving key")
			return
		case <-ticker.C:
			if err := c.retrieveKey(org); err != nil {
				log.Error(err)
			} else {
				return
			}
		}
	}
}

func (c *KmsCipherManager) retrieveKey(org string) error {
	var key []byte
	req, err := http.NewRequest(http.MethodGet, c.serverUrlBase+retrieveEncryptKeyPath, nil)
	pars := req.URL.Query()
	pars[parameterOrganization] = []string{org}
	req.URL.RawQuery = pars.Encode()
	req.Header.Set("Authorization", "Bearer "+services.Config().GetString(configBearerToken))
	log.Debugf("Retrieving key: %s", req.URL.String())
	if err != nil {
		return fmt.Errorf("failed to create retrieving key request for org=%s : %v", org, err)
	}
	res, err := c.client.Do(req)
	if err != nil {
		return fmt.Errorf("failed to retrieve key for org=%s : %v", org, err)
	}
	if res.StatusCode != http.StatusOK {
		err = fmt.Errorf("failed to retrieve key for org [%v] with status: %v", org, res.Status)
		return fmt.Errorf("failed to create retrieving key request for org=%s : %v", org, err)
	}

	log.Debugf("Downloaded Encryption Key for org %s", org)
	key64, err := ioutil.ReadAll(res.Body)
	res.Body.Close()
	if err != nil {
		return fmt.Errorf("error reading encryption key: %v", err)
	}
	key, err = base64.StdEncoding.DecodeString(string(key64))
	if err != nil {
		return fmt.Errorf("error decoding encryption key: %v", err)
	}
	log.Debugf("Encryption Key successfully retrieved for org %s", org)
	a, err := cipher.CreateAesCipher(key)
	if err != nil {
		return fmt.Errorf("CreateAesCipher error for org [%v] when CreateAesCipher: %v", org, err)
	}
	c.mutex.Lock()
	c.key[org] = key
	c.aes[org] = a
	c.mutex.Unlock()
	return nil
}

func (c *KmsCipherManager) getAesCipher(org string) *cipher.AesCipher {
	// if exists
	c.mutex.RLock()
	if a := c.aes[org]; a != nil {
		c.mutex.RUnlock()
		return a
	}
	// if not exists
	c.mutex.RUnlock()
	c.startRetrieve(org, c.interval, c.timeout)
	c.mutex.RLock()
	defer c.mutex.RUnlock()
	return c.aes[org]
}

// If input is encrypted, it decodes the input with base64,
// and then decrypt it. Otherwise, original input is returned.
// An encrypted input should be ciphertext prepended with algorithm. An unencrypted input can have any other format.
// An example of encrypted input is "{AES/ECB/PKCS5Padding}2jX3V3dQ5xB9C9Zl9sqyo8pmkvVP10rkEVPVhmnLHw4=".
func (c *KmsCipherManager) TryDecryptBase64(input string, org string) (output string, err error) {
	if !IsEncrypted(input) {
		output = input
		return
	}

	text, mode, padding, err := GetCiphertext(input)
	if err != nil {
		log.Errorf("Get ciphertext of [%v] failed: [%v], considered as unencrypted!", input, err)
		return
	}
	bytes, err := base64.StdEncoding.DecodeString(text)
	if err != nil {
		log.Errorf("Decode base64 of [%v] failed: [%v], considered as unencrypted!", text, err)
		return
	}
	plaintext, err := c.getAesCipher(org).Decrypt(bytes, mode, padding)
	if err != nil {
		log.Errorf("Decrypt of [%v] failed: [%v], considered as unencrypted!", bytes, err)
		return
	}
	output = string(plaintext)
	return
}

// It encrypts the input, and then encodes the ciphertext with base64.
// The returned string is the base64 encoding of the encrypted input, prepended with algorithm.
// An example output is "{AES/ECB/PKCS5Padding}2jX3V3dQ5xB9C9Zl9sqyo8pmkvVP10rkEVPVhmnLHw4="
func (c *KmsCipherManager) EncryptBase64(input string, org string, mode cipher.Mode, padding cipher.Padding) (output string, err error) {
	ciphertext, err := c.getAesCipher(org).Encrypt([]byte(input), mode, padding)
	if err != nil {
		return
	}
	output = fmt.Sprintf("{%s/%s/%s}%s", EncryptAes, mode, padding, base64.StdEncoding.EncodeToString(ciphertext))
	return
}

// TODO: make sure this regex has no false positive for all possible inputs
func IsEncrypted(input string) (encrypted bool) {
	return RegexpEncrypted.Match([]byte(input))
}

func GetCiphertext(input string) (ciphertext string, mode cipher.Mode, padding cipher.Padding, err error) {
	l := strings.SplitN(input, "}", 2)
	if len(l) != 2 {
		err = fmt.Errorf("invalid input for GetCiphertext: %v", input)
		return
	}
	ciphertext = l[1]
	l = strings.Split(strings.TrimLeft(l[0], "{"), "/")
	if len(l) != 3 {
		err = fmt.Errorf("invalid input for GetCiphertext: %v", input)
		return
	}
	// encryption algorithm
	if l[0] != EncryptAes {
		err = fmt.Errorf("unsupported algorithm for GetCiphertext: %v", l[0])
		return
	}
	// mode
	mode = cipher.Mode(l[1])
	// padding
	padding = cipher.Padding(l[2])
	return
}