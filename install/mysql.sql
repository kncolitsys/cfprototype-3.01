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

DROP TABLE IF EXISTS `cfp_note`;

CREATE TABLE `cfp_note` (
  `id` int(11) NOT NULL,
  `note_lft` int(11) NOT NULL,
  `note_rgt` int(11) NOT NULL,
  `prototype_id` varchar(100) NOT NULL,
  `note_text` text default '',
  `page_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note_date` datetime NOT NULL,
  `is_completed` char(1) NOT NULL default 'N',
  PRIMARY KEY  (`id`)
);

DROP TABLE IF EXISTS `cfp_page`;

CREATE TABLE `cfp_page` (
  `id` int(11) NOT NULL,
  `page_name` varchar(100) NOT NULL,
  `prototype_id` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
);

DROP TABLE IF EXISTS `cfp_user`;

CREATE TABLE `cfp_user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `is_admin` char(1) NOT NULL default 'N',
  `is_active` char(1) NOT NULL default 'Y',
  `is_notify` char(1) NOT NULL default 'Y',
  `prototype_id` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
);
