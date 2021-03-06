-- Copyright 2017 Google Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE kms_app (id text,tenant_id text,name text,display_name text,access_type text,callback_url text,status text,app_family text,company_id text,developer_id text,parent_id text,type text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id));
INSERT INTO "kms_app" VALUES('408ad853-3fa0-402f-90ee-103de98d71a5','515211e9','apstest','apstest','READ','https://www.google.com','APPROVED','default','','e41f04e8-9d3f-470a-8bfd-c7939945896c','e41f04e8-9d3f-470a-8bfd-c7939945896c','DEVELOPER','2017-08-18 22:13:18.325+00:00','haoming@apid.git','2017-08-18 22:13:18.325+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_app" VALUES('ae053aee-f12d-4591-84ef-2e6ae0d4205d','515211e9','apigee-remote-proxy','','','','APPROVED','default','','590f33bf-f05c-48c1-bb93-183759bd9ee1','590f33bf-f05c-48c1-bb93-183759bd9ee1','DEVELOPER','2017-09-20 23:05:59.125+00:00','haoming@apid.git','2017-09-20 23:05:59.125+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_app" VALUES('35608afe-2715-4064-bb4d-3cbb4e82c474','515211e9','testappahhis','testappahhis','READ','','APPROVED','default','a94f75e2-69b0-44af-8776-155df7c7d22e','','a94f75e2-69b0-44af-8776-155df7c7d22e','COMPANY','2017-11-02 16:00:16.504+00:00','haoming@apid.git','2017-11-02 16:00:16.504+00:00','haoming@apid.git','515211e9');
CREATE TABLE kms_attributes (tenant_id text,entity_id text,cust_id text,org_id text,dev_id text,comp_id text,apiprdt_id text,app_id text,appcred_id text,name text,type text,value text,_change_selector text, primary key (tenant_id,entity_id,name,type));
INSERT INTO "kms_attributes" VALUES('515211e9','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','','','','','features.isSmbOrganization','ORGANIZATION','false','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','','','','','features.mgmtGroup','ORGANIZATION','management-edgex','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','','','','','features.isEdgexEnabled','ORGANIZATION','true','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','e2cc4caf-40d6-4ecb-8149-ed32d04184b2','','','','','','features.isCpsEnabled','ORGANIZATION','true','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','b7e0970c-4677-4b05-8105-5ea59fdcf4e7','','','','','b7e0970c-4677-4b05-8105-5ea59fdcf4e7','','','access','APIPRODUCT','public','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','408ad853-3fa0-402f-90ee-103de98d71a5','','','','','','408ad853-3fa0-402f-90ee-103de98d71a5','','DisplayName','APP','apstest','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','408ad853-3fa0-402f-90ee-103de98d71a5','','','','','','408ad853-3fa0-402f-90ee-103de98d71a5','','Notes','APP','','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','db90a25a-15c8-42ad-96c1-63ed9682b5a9','','','','','db90a25a-15c8-42ad-96c1-63ed9682b5a9','','','access','APIPRODUCT','public','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','ae053aee-f12d-4591-84ef-2e6ae0d4205d','','','','','','ae053aee-f12d-4591-84ef-2e6ae0d4205d','','DisplayName','APP','apigee-remote-proxy','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','ae053aee-f12d-4591-84ef-2e6ae0d4205d','','','','','','ae053aee-f12d-4591-84ef-2e6ae0d4205d','','Notes','APP','','515211e9');
INSERT INTO "kms_attributes" VALUES('515211e9','fea8a6d5-8d34-477f-ac82-c397eaec06af','','','','','fea8a6d5-8d34-477f-ac82-c397eaec06af','','','Company','APIPRODUCT','Apigee','515211e9');
CREATE TABLE kms_company (id text,tenant_id text,name text,display_name text,status text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id));
INSERT INTO "kms_company" VALUES('8ba5b747-5104-4a40-89ca-a0a51798fe34','515211e9','DevCompany','East India Company','ACTIVE','2017-08-15 03:29:02.449+00:00','haoming@apid.git','2017-08-15 03:29:02.449+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_company" VALUES('a94f75e2-69b0-44af-8776-155df7c7d22e','515211e9','testcompanyhflxv','testcompanyhflxv','ACTIVE','2017-11-02 16:00:16.287+00:00','haoming@apid.git','2017-11-02 16:00:16.287+00:00','haoming@apid.git','515211e9');
CREATE TABLE kms_company_developer (tenant_id text,company_id text,developer_id text,roles text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (tenant_id,company_id,developer_id));
INSERT INTO "kms_company_developer" VALUES('515211e9','a94f75e2-69b0-44af-8776-155df7c7d22e','590f33bf-f05c-48c1-bb93-183759bd9ee1','admin','2017-11-02 16:00:16.287+00:00','haoming@apid.git','2017-11-02 16:00:16.287+00:00','haoming@apid.git','515211e9');
CREATE TABLE kms_developer (id text,tenant_id text,username text,first_name text,last_name text,password text,email text,status text,encrypted_password text,salt text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id));
INSERT INTO "kms_developer" VALUES('e41f04e8-9d3f-470a-8bfd-c7939945896c','515211e9','haoming','haoming','zhang','','bar@google.com','ACTIVE','','','2017-08-16 22:39:46.669+00:00','foo@google.com','2017-08-16 22:39:46.669+00:00','foo@google.com','515211e9');
INSERT INTO "kms_developer" VALUES('47d862db-884f-4b8e-9649-fe6d0be1a739','515211e9','qwe','qwe','qwe','','barfoo@google.com','ACTIVE','','','2017-10-12 19:12:48.306+00:00','haoming@apid.git','2017-10-12 19:12:48.306+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_developer" VALUES('590f33bf-f05c-48c1-bb93-183759bd9ee1','515211e9','remoteproxy','remote','proxy','','fooo@google.com','ACTIVE','','','2017-09-20 23:03:52.327+00:00','haoming@apid.git','2017-09-20 23:03:52.327+00:00','haoming@apid.git','515211e9');
CREATE TABLE edgex_apid_cluster (id text,name text,description text,umbrella_org_app_name text,created blob,created_by text,updated blob,updated_by text,_change_selector text, last_sequence text DEFAULT '', primary key (id));
INSERT INTO "edgex_apid_cluster" VALUES('950b30f1-8c41-4bf5-94a3-f10c104ff5d4','apid-haomingOrgCluster','','X-sZXhaOymL6VtWnNQqK7uPsFyPvZYq6FFnrc8','2017-08-23 23:31:49.134+00:00','temp@google.com','2017-08-23 23:31:49.134+00:00','temp@google.com','950b30f1-8c41-4bf5-94a3-f10c104ff5d4','');
CREATE TABLE kms_api_product (id text,tenant_id text,name text,display_name text,description text,api_resources text,approval_type text,scopes text,proxies text,environments text,quota text,quota_time_unit text,quota_interval integer,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id));
INSERT INTO "kms_api_product" VALUES('b7e0970c-4677-4b05-8105-5ea59fdcf4e7','515211e9','apstest','apstest','','{/**}','AUTO','{""}','{aps,perfBenchmark}','{prod,test}','10000000','MINUTE',1,'2017-08-18 22:12:49.363+00:00','haoming@apid.git','2017-08-18 22:26:50.153+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_api_product" VALUES('8501392f-c5f7-4d6a-8841-e038ad5913b4','515211e9','ApigeenTestApp','ApigeenTestApp','','{/}','AUTO','{scope1,scope2,scope3}','{}','{prod,test}','','',NULL,'2017-09-20 22:29:06.451+00:00','haoming@apid.git','2017-09-20 22:29:06.451+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_api_product" VALUES('e4ae89d0-ea47-4b23-b0dc-2723efb15c84','515211e9','ApigeenTestApp2','ApigeenTestApp2','','{/}','AUTO','{scope1,scope2,scope3}','{}','{prod,test}','','',NULL,'2017-09-20 22:29:08.988+00:00','haoming@apid.git','2017-09-20 22:29:08.988+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_api_product" VALUES('07419482-e5a1-4fd0-9d78-3560ba522b44','515211e9','ApigeenTestApp3','ApigeenTestApp3','','{/}','AUTO','{}','{}','{prod,test}','','',NULL,'2017-09-20 22:29:11.482+00:00','haoming@apid.git','2017-09-20 22:29:11.482+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_api_product" VALUES('db90a25a-15c8-42ad-96c1-63ed9682b5a9','515211e9','apigee-remote-proxy','apigee-remote-proxy','','{/**,/}','AUTO','{""}','{apigee-remote-proxy}','{prod,test}','','',NULL,'2017-09-20 23:05:09.234+00:00','haoming@apid.git','2017-09-20 23:05:09.234+00:00','haoming@apid.git','515211e9');
INSERT INTO "kms_api_product" VALUES('fea8a6d5-8d34-477f-ac82-c397eaec06af','515211e9','testproductsdljnkpt','testproductsdljnkpt','','{/res1}','AUTO','{}','{}','{test}','','',NULL,'2017-11-02 16:00:15.608+00:00','haoming@apid.git','2017-11-02 16:00:18.125+00:00','haoming@apid.git','515211e9');
CREATE TABLE kms_app_credential (id text,tenant_id text,consumer_secret text,app_id text,method_type text,status text,issued_at blob,expires_at blob,app_status text,scopes text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id));
INSERT INTO "kms_app_credential" VALUES('abcd','515211e9','encrypted:secret1','408ad853-3fa0-402f-90ee-103de98d71a5','','APPROVED','2017-08-18 22:13:18.35+00:00','','','{}','2017-08-18 22:13:18.35+00:00','-NA-','2017-08-18 22:13:18.352+00:00','-NA-','515211e9');
INSERT INTO "kms_app_credential" VALUES('dcba','515211e9','encrypted:secret2','ae053aee-f12d-4591-84ef-2e6ae0d4205d','','APPROVED','2017-09-20 23:05:59.148+00:00','','','{}','2017-09-20 23:05:59.148+00:00','-NA-','2017-09-20 23:05:59.151+00:00','-NA-','515211e9');
INSERT INTO "kms_app_credential" VALUES('wxyz','515211e9','encrypted:secret3','35608afe-2715-4064-bb4d-3cbb4e82c474','','APPROVED','2017-11-02 16:00:16.512+00:00','','','{}','2017-11-02 16:00:16.512+00:00','-NA-','2017-11-02 16:00:16.514+00:00','-NA-','515211e9');
CREATE TABLE kms_app_credential_apiproduct_mapper (tenant_id text,appcred_id text,app_id text,apiprdt_id text,status text,_change_selector text, primary key (tenant_id,appcred_id,app_id,apiprdt_id));
INSERT INTO "kms_app_credential_apiproduct_mapper" VALUES('515211e9','abcd','408ad853-3fa0-402f-90ee-103de98d71a5','b7e0970c-4677-4b05-8105-5ea59fdcf4e7','APPROVED','515211e9');
INSERT INTO "kms_app_credential_apiproduct_mapper" VALUES('515211e9','dcba','ae053aee-f12d-4591-84ef-2e6ae0d4205d','db90a25a-15c8-42ad-96c1-63ed9682b5a9','APPROVED','515211e9');
INSERT INTO "kms_app_credential_apiproduct_mapper" VALUES('515211e9','wxyz','35608afe-2715-4064-bb4d-3cbb4e82c474','fea8a6d5-8d34-477f-ac82-c397eaec06af','APPROVED','515211e9');
CREATE TABLE kms_organization (id text,name text,display_name text,type text,tenant_id text,customer_id text,description text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id));
INSERT INTO "kms_organization" VALUES('e2cc4caf-40d6-4ecb-8149-ed32d04184b2','apid-haoming','apid-haoming','paid','515211e9','94cd5075-7f33-4afb-9545-a53a254277a1','','2017-08-16 22:16:06.544+00:00','foobar@google.com','2017-08-16 22:29:23.046+00:00','foobar@google.com','515211e9');
COMMIT;
