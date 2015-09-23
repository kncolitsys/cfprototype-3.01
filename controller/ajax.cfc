<!---
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

--->

<cfcomponent output="false" displayname="devnote" hint="">

<cffunction name="postfuseaction" access="public" returntype="void" output="true" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset event.setValue( 'json', myFusebox.getBean( 'JSON' ) ) />
	<cfset myFusebox.do( action = 'vcfprototype.dsp_ajax' ) />
</cffunction>

<cffunction name="addnote" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset ret.valid = true />
	<cftry>
		<cfset ret.data =  myFusebox.getBean( 'NoteService' ).addNote( 	page_id = event.getValue( 'page_id' ),
																		parent_id = event.getValue( 'parent_id' ),
																		note_text = event.getValue( 'note_text' ) ) />
		<cfcatch type="any">
			<cfset ret.valid = false />
			<cfset ret.message = cfcatch.Message & '::::' & cfcatch.Detail />
		</cfcatch>																
	</cftry>
	<cfset event.setValue( 'ajax_result', ret ) />
</cffunction>

<cffunction name="removenote" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset ret.valid = true />
	<cftry>
		<cfset ret.data = myFusebox.getBean( 'NoteService' ).removeNote( 	page_id = event.getValue( 'page_id' ),
																			note_id = event.getValue( 'note_id' ) ) />
		<cfcatch type="any">
			<cfset ret.valid = false />
			<cfset ret.message = cfcatch.Message & '::::' & cfcatch.Detail />
		</cfcatch>																
	</cftry>
	<cfset event.setValue( 'ajax_result', ret ) />
</cffunction>

<cffunction name="completenote" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset ret.valid = true />
	<cftry>
		<cfset ret.data =  myFusebox.getBean( 'NoteService' ).completeNote( page_id = event.getValue( 'page_id' ),
																			note_id = event.getValue( 'note_id' ) ) />
		<cfcatch type="any">
			<cfset ret.valid = false />
			<cfset ret.message = cfcatch.Message & '::::' & cfcatch.Detail />
		</cfcatch>																
	</cftry>
	<cfset event.setValue( 'ajax_result', ret ) />
</cffunction>

<cffunction name="saveuser" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset ret.valid = true />
	<cftry>
		<cfset ret.data =  myFusebox.getBean( 'UserService' ).saveuser(	user_id = event.getValue( 'user_id' ),
																		first_name = event.getValue( 'first_name' ),
																		last_name = event.getValue( 'last_name' ),
																		email = event.getValue( 'email' ),
																		username = event.getValue( 'username' ),
																		password = event.getValue( 'password' ),
																		is_admin = event.getValue( 'is_admin',  'N' ),	
																		is_active = event.getValue( 'is_active',  'N' ),
																		is_notify = event.getValue( 'is_notify',  'N' )	) />
		<cfcatch type="any">
			<cfset ret.valid = false />
			<cfset ret.message = cfcatch.Message & '::::' & cfcatch.Detail />
		</cfcatch>																
	</cftry>
	<cfset event.setValue( 'ajax_result', ret ) />
</cffunction>

<cffunction name="deleteuser" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset ret.valid = true />
	<cftry>
		<cfset ret.data =  myFusebox.getBean( 'UserService' ).deleteUser( user_id = event.getValue( 'user_id' ) ) />
		<cfcatch type="any">
			<cfset ret.valid = false />
			<cfset ret.message = cfcatch.Message & '::::' & cfcatch.Detail />
		</cfcatch>																
	</cftry>
	<cfset event.setValue( 'ajax_result', ret ) />
</cffunction>

<cffunction name="deletepage" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset ret.valid = true />
	<cftry>
		<cfset ret.data =  myFusebox.getBean( 'PageService' ).deletePage( page_id = event.getValue( 'page_id' ) ) />
		<cfcatch type="any">
			<cfset ret.valid = false />
			<cfset ret.message = cfcatch.Message & '::::' & cfcatch.Detail />
		</cfcatch>																
	</cftry>
	<cfset event.setValue( 'ajax_result', ret ) />
</cffunction>

</cfcomponent>