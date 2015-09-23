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
<cfcomponent output="false" displayname="RSSService" hint="" extends="AbstractService">

<cffunction name="init" returntype="RSSService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<cffunction name="configure" returntype="void" access="public" output="false" hint="">
	<cfset var meta =  StructNew() />
	<cfset meta.title = getConfig().get( 'prototypetitle' ) />
	<cfset meta.link = getConfig().get( 'applicationurl' ) />
	<cfset meta.description = getConfig().get( 'PrototypeTitle' ) & ' Site' />
	<cfset setMeta( meta ) />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="generateRSS" returntype="xml" access="public" output="false" hint="">
	<cfset var notesData = getNoteDAO().getNotesForPrototype() />
	<cfset var rssQuery = QueryNew( 'link,title,body,date', 'VARCHAR,VARCHAR,VARCHAR,VARCHAR' ) />
	<cfloop query="notesData">
		<cfset QueryAddRow( rssQuery ) />
		<cfset QuerySetCell( rssQuery, 'link',  getConfig().get( 'applicationurl' ) & '?page=' & URLEncodedFormat( page_name ) ) />
		<cfset QuerySetCell( rssQuery, 'title', getConfig().get( 'PrototypeTitle' ) & ' : Page ' & page_name ) />
		<cfset QuerySetCell( rssQuery, 'body', note_text ) />
		<cfset QuerySetCell( rssQuery, 'date', note_date ) /> 
	</cfloop>
	<cfreturn CreateObject( 'component', 'RSS' ).generateRSS( 'RSS1', rssQuery, getMeta() ) />
</cffunction>


<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getMeta" access="private" returntype="struct" output="false" hint="Getter for Meta">
	<cfreturn variables.instance.Meta />
</cffunction>

<cffunction name="setMeta" access="private" returntype="void" output="false" hint="Setter for Meta">
	<cfargument name="Meta" type="struct" required="true" />
	<cfset variables.instance.Meta = arguments.Meta>
</cffunction>

<cffunction name="getNoteDAO" access="public" returntype="NoteDAO" output="false" hint="Getter for NoteDAO">
	<cfreturn variables.instance.NoteDAO />
</cffunction>

<cffunction name="setNoteDAO" access="public" returntype="void" output="false" hint="Setter for NoteDAO">
	<cfargument name="NoteDAO" type="NoteDAO" required="true" />
	<cfset variables.instance.NoteDAO = arguments.NoteDAO>
</cffunction>

</cfcomponent>