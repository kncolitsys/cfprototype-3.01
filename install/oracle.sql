/***
CFPrototype version 2.0
Copyright 2008, Qasim Rasheed

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

$Date: 2008-07-04 21:55:02 -0400 (Fri, 04 Jul 2008) $
$Revision: 78 $
*/
CREATE TABLE CFP_USER
(
  ID            INTEGER                         NOT NULL,
  FIRST_NAME    VARCHAR2(50 BYTE)               NOT NULL,
  LAST_NAME     VARCHAR2(50 BYTE)               NOT NULL,
  EMAIL         VARCHAR2(50 BYTE)               NOT NULL,
  IS_ADMIN      CHAR(1 BYTE)                    DEFAULT 'N'                   NOT NULL,
  PROTOTYPE_ID  VARCHAR2(50 BYTE)               NOT NULL,
  USERNAME      VARCHAR2(50 BYTE)               NOT NULL,
  PASSWORD      VARCHAR2(50 BYTE)               NOT NULL,
  IS_ACTIVE     CHAR(1 BYTE)                    DEFAULT 'Y'                   NOT NULL,
  IS_NOTIFY     CHAR(1 BYTE)
);

CREATE TABLE CFP_PAGE
(
  ID            INTEGER                         NOT NULL,
  PAGE_NAME     VARCHAR2(100 BYTE)              NOT NULL,
  PROTOTYPE_ID  VARCHAR2(50 BYTE)               NOT NULL
);

CREATE TABLE CFP_NOTE
(
  ID            INTEGER                         NOT NULL,
  NOTE_LFT      INTEGER                         NOT NULL,
  NOTE_RGT      INTEGER                         NOT NULL,
  NOTE_TEXT     VARCHAR2(2000 BYTE)             NOT NULL,
  PROTOTYPE_ID  VARCHAR2(50 BYTE)               NOT NULL,
  PAGE_ID       INTEGER                         NOT NULL,
  NOTE_DATE     DATE                            NOT NULL,
  IS_COMPLETED  CHAR(1 BYTE)                    DEFAULT 'N'                   NOT NULL,
  USER_ID       INTEGER                         NOT NULL
);

CREATE UNIQUE INDEX CFP_NOTE_PK ON CFP_NOTE
(ID);


CREATE UNIQUE INDEX CFP_PAGE_PK ON CFP_PAGE
(ID);

ALTER TABLE CFP_USER ADD (
  	PRIMARY KEY
 	(ID) 
);

ALTER TABLE CFP_PAGE ADD (
  	CONSTRAINT CFP_PAGE_PK
 	PRIMARY KEY
 	(ID)
);

ALTER TABLE CFP_NOTE ADD (
	CONSTRAINT CFP_NOTE_PK
 	PRIMARY KEY
 	(ID)
);

