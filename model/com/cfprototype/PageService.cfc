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
<cfcomponent output="false" displayname="PageService" hint="" extends="AbstractService">

<cffunction name="init" returntype="PageService" output="false" access="public" hint="Constructor">
	<cfreturn super.init() />	
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="getDefaultLayout" returntype="string" access="public" output="false" hint="">
	<cfreturn getConfig().get( 'layouts' ).get( 'defaultLayout' ) />
</cffunction>

<!--- <cffunction name="generateReport" returntype="any" access="public" output="false" hint="">
	<cfset var local = StructNew() />
	<cfset local.qPageList = getAllPages() />
	<cfset local.report = ArrayNew(1) />
	<cfloop query="local.qPageList">
		<cfset local.tempStruct = StructNew() />
		<cfset local.tempStruct.pageName = page_name />
		<cfset local.tempStruct.pageContent = getSiteLayout( page = page_name ) />
		<cfset local.tempStruct.pageNotes = getNoteService().getNotesForPage( page_id = id, dolinks = false ) />
		<cfset ArrayAppend( local.report, local.tempStruct ) />
	</cfloop>
	<cfreturn local.report />
</cffunction> --->

<cffunction name="createPage" returntype="void" access="public" output="false" hint="">
	<cfargument name="page" type="string" required="true" hint="" />
	<cfif Len( Trim( arguments.page ) ) AND NOT hasPage( arguments.page )>
		<cfset getPageDAO().create( page_name = arguments.page ) />
	</cfif>
</cffunction>

<cffunction name="getPageId" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="page" type="string" required="true" hint="" />
	<cfreturn getPageDAO().read( page_name = arguments.page ).id />
</cffunction>

<cffunction name="getAllPages" returntype="query" access="public" output="false" hint="">
	<cfreturn getPageDAO().list() />
</cffunction>

<cffunction name="deletePage" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfset getPageDAO().delete( arguments.page_id ) />
	<cfreturn arguments.page_id />
</cffunction>

<!--- <cffunction name="pageExists" returntype="boolean" access="public" output="false" hint="">
	<cfargument name="page" type="string" required="true" hint="" />
	<cfset var ret = FileExists( ExpandPath( 'view/html' ) &  '\' & arguments.page & '.htm' ) />
	<cfif NOT ret>
		<cfset ret = FileExists( ExpandPath( 'view/html' ) &  '\' & arguments.page & '.cfm' ) />
	</cfif>
	<cfreturn ret />
</cffunction> --->

<!--- PRIVATE METHODS --->
<cffunction name="hasPage" returntype="boolean" access="private" output="false" hint="">
	<cfargument name="page" type="string" required="true" hint="" />
	<cfreturn getPageDAO().read( page_name = arguments.page ).recordcount GT 0 />
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getPageDAO" access="public" returntype="PageDAO" output="false" hint="Getter for PageDAO">
	<cfreturn variables.instance.PageDAO />
</cffunction>

<cffunction name="setPageDAO" access="public" returntype="void" output="false" hint="Setter for PageDAO">
	<cfargument name="PageDAO" type="PageDAO" required="true" />
	<cfset variables.instance.PageDAO = arguments.PageDAO>
</cffunction>

<cffunction name="getNoteService" access="public" returntype="NoteService" output="false" hint="Getter for NoteService">
	<cfreturn variables.instance.NoteService />
</cffunction>

<cffunction name="setNoteService" access="public" returntype="void" output="false" hint="Setter for NoteService">
	<cfargument name="NoteService" type="NoteService" required="true" />
	<cfset variables.instance.NoteService = arguments.NoteService>
</cffunction>

</cfcomponent>