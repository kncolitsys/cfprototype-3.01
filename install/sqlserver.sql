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
CREATE TABLE [dbo].[cfp_page](
	[id] [int] NOT NULL,
	[page_name] [varchar](100) NOT NULL,
	[prototype_id] [varchar](50) NOT NULL,
 	CONSTRAINT [PK_cfp_page] PRIMARY KEY CLUSTERED 
		(
			[id] ASC
		)
) ON [PRIMARY]

CREATE TABLE [dbo].[cfp_user](
	[id] [int] NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[is_admin] [char](1) NOT NULL CONSTRAINT [DF_cfp_user_is_admin]  DEFAULT ('N'),
	[prototype_id] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[is_active] [char](1) NOT NULL CONSTRAINT [DF_cfp_user_is_active]  DEFAULT ('Y'),
	[is_notify] [char](1) NOT NULL CONSTRAINT [DF_cfp_user_is_notify]  DEFAULT ('Y'),
 	CONSTRAINT [PK_cfp_user] PRIMARY KEY CLUSTERED 
		(
			[id] ASC
		)
) ON [PRIMARY]

CREATE TABLE [dbo].[cfp_note](
	[id] [int] NOT NULL,
	[note_lft] [int] NOT NULL,
	[note_rgt] [int] NOT NULL,
	[note_text] [varchar](2000) NOT NULL,
	[prototype_id] [varchar](50) NOT NULL,
	[page_id] [int] NOT NULL,
	[note_date] [datetime] NOT NULL,
	[is_completed] [char](1) NOT NULL CONSTRAINT [DF_cfp_note_is_completed]  DEFAULT ('N'),
	[user_id] [int] NOT NULL,
 	CONSTRAINT [PK_cfp_note] PRIMARY KEY CLUSTERED 
		(
			[id] ASC
		)
) ON [PRIMARY]

