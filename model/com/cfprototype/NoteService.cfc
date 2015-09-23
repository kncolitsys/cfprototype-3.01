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
<cfcomponent output="false" displayname="NoteService" hint="" extends="AbstractService">

<cffunction name="init" returntype="NoteService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="createRootNode" returntype="void" access="public" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfif getNoteDAO().read( page_id = arguments.page_id ).recordcount EQ 0>
		<cfset getNoteDAO().createRoot( page_id = arguments.page_id, user_id = getSecurityService().getUserID() ) />
	</cfif>
</cffunction>

<cffunction name="getRootNoteID" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfset var qRead = getNoteDAO().read( page_id = arguments.page_id, note_text = 'root' ) />
	<cfreturn qRead.id />
</cffunction>

<cffunction name="getNotesForPage" returntype="string" access="public" output="false" hint="">
	<cfargument name="page_id" type="string" required="true" hint="" />
	<cfargument name="is_completed" type="string" default="" hint="" />
	<cfargument name="dolinks" type="boolean" default="true" hint="" />
	<cfset var qNotes = getNoteDAO().getNotesForPage( arguments.page_id, arguments.is_completed ) />
	<cfset var noteParser = CreateObject( 'component', 'NoteParser' ).init( qNotes ) />
	<cfreturn noteParser.formatNotes( isadmin = getSecurityService().isAdmin(), dolinks = arguments.dolinks ) />
</cffunction>

<cffunction name="addNote" returntype="struct" access="public" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="parent_id" type="numeric" required="true" hint="" />
	<cfargument name="note_text" type="string" required="true" hint="" />
	<cfset var ret = StructNew() />
	<cfset ret  = getNoteDAO().insertNote( 	page_id = arguments.page_id, 
												parent_id = arguments.parent_id, 
												user_id = getSecurityService().getUserID(),	
												note_text = arguments.note_text ) />
	<cfset ret = getUDF().queryRowToStruct( ret ) />
	<cfset ret.parent_id = arguments.parent_id />
	<!--- <cfset sendNotification( ret ) /> --->
	<cfreturn ret />																																
</cffunction>

<cffunction name="removeNote" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="note_id" type="numeric" required="true" hint="" />
	<cfset getNoteDAO().removeNote( page_id = arguments.page_id, 
									note_id = arguments.note_id ) />
	<cfreturn arguments.note_id />								
</cffunction>

<cffunction name="completeNote" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="note_id" type="numeric" required="true" hint="" />
	<cfset getNoteDAO().completeNote( 	page_id = arguments.page_id, 
										note_id = arguments.note_id ) />										 
	<cfreturn arguments.note_id />								
</cffunction>

<!--- PRIVATE METHODS --->
<cffunction name="sendNotification" returntype="void" access="private" output="false" hint="">
	<cfargument name="noteData" type="struct" required="true" hint="" />
	<cfset var local = StructNew() />
	<cfinvoke component="#getUserDAO()#" method="getPrototypeRecipients" returnvariable="local.recipients">
		<cfif NOT getConfig().getEmailPoster()>
			<cfinvokeargument name="poster_id" value="#arguments.noteData.user_id#" />
		</cfif>
	</cfinvoke>
	<cfset local.recipients  = 'rasheed@niehs.nih.gov' />
	<cfif Len( Trim( local.recipients ) )>
		<cfmail 	from="#getConfig().getFromEmail()#" 
					to="#local.recipients#" 
					server="#getConfig().getMailServer()#" 
					subject="#getConfig().getPrototypeTitle()# Question Added by #arguments.noteData.first_name# #arguments.noteData.last_name#">						
This email is being sent automatically. A question that you are participating in at the #getConfig().getPrototypeTitle()# has been updated. 

You can go to #getConfig().getApplicationURL()#?page=#arguments.noteData.page_name# to view the page and the question thread. 

Here is the response that was posted by #arguments.noteData.first_name# #arguments.noteData.last_name#:
#arguments.noteData.note_text#

Thanks for participating in the Prototype. Your help allows us to refine the Prototype and deliver an application that meets everyone's needs.

Date Sent: #DateFormat( Now(), 'medium' )#
Time Sent: #TimeFormat( Now(), 'short' )#	
		</cfmail>			
	</cfif>	
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getSecurityService" access="public" returntype="SecurityService" output="false" hint="Getter for SecurityService">
	<cfreturn variables.instance.SecurityService />
</cffunction>

<cffunction name="setSecurityService" access="public" returntype="void" output="false" hint="Setter for SecurityService">
	<cfargument name="SecurityService" type="SecurityService" required="true" />
	<cfset variables.instance.SecurityService = arguments.SecurityService>
</cffunction>

<cffunction name="getNoteDAO" access="public" returntype="NoteDAO" output="false" hint="Getter for NoteDAO">
	<cfreturn variables.instance.NoteDAO />
</cffunction>

<cffunction name="setNoteDAO" access="public" returntype="void" output="false" hint="Setter for NoteDAO">
	<cfargument name="NoteDAO" type="NoteDAO" required="true" />
	<cfset variables.instance.NoteDAO = arguments.NoteDAO>
</cffunction>

<cffunction name="getUserDAO" access="public" returntype="UserDAO" output="false" hint="Getter for UserDAO">
	<cfreturn variables.instance.UserDAO />
</cffunction>

<cffunction name="setUserDAO" access="public" returntype="void" output="false" hint="Setter for UserDAO">
	<cfargument name="UserDAO" type="UserDAO" required="true" />
	<cfset variables.instance.UserDAO = arguments.UserDAO>
</cffunction>

</cfcomponent>