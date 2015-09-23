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

<cfcomponent output="false" displayname="prototype" hint="">

<cffunction name="prefuseaction" access="public" returntype="void" output="false" hint="This just acts as prefuseaction .">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfif NOT myFusebox.getBean( 'SecurityService' ).isLoggedIn()>
		<cfset event.xfa( 'login' , 'admin.login', 'returnpage', event.getValue( 'page' ) ) />
		<cfset myFusebox.relocate( 	xfa = 'login', 
									addtoken = 'false', 
									type='client')>
	</cfif>
	<cfif NOT event.valueExists( 'page' ) OR ( event.valueExists( 'page' ) AND NOT Len( Trim( event.getValue( 'page' ) ) ) )>
		<cfset event.setValue( 'page', myFusebox.getBean( 'config' ).get( 'defaultPage' ) ) />
	</cfif>
	<!--- <cfif NOT myFusebox.getBean( 'PageService' ).pageExists( event.getValue( 'page' ) )> --->
		<cfset myFusebox.getBean( 'PageService' ).createPage( event.getValue( 'page' ) ) />
		<cfset event.setValue( 'page_id', myFusebox.getBean( 'PageService' ).getPageId( event.getValue( 'page' ) ) ) />
		<cfset myFusebox.getBean( 'NoteService' ).createRootNode( event.getValue( 'page_id' ) ) />
		<cfset event.setValue( 'root_note_id', myFusebox.getBean( 'NoteService' ).getRootNoteID( event.getValue( 'page_id' ) ) ) />	
	<!--- </cfif> --->
	<cfset event.setValue( 'isAdmin', myFusebox.getBean( 'SecurityService' ).isAdmin() ) />
	<cfset event.setValue( 'isLoggedIn', myFusebox.getBean( 'SecurityService' ).isLoggedIn() ) />
</cffunction>

<cffunction name="main" returntype="void" access="public" output="true" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset event.xfa( 'delete', 'ajax.removenote', 'page_id', event.getValue( 'page_id' ) ) />
	<cfset event.xfa( 'complete', 'ajax.completenote', 'page_id', event.getValue( 'page_id' ) ) />
	<cfset event.xfa( 'insert', 'ajax.addnote', 'page_id', event.getValue( 'page_id' ) ) />
	<cfset event.xfa( 'admin', 'admin.main' ) />
	<cfset event.xfa( 'logout', 'admin.logout' ) />
	<cfset event.xfa( 'rss', 'rss' ) />
	
	<cfset event.setValue( 'defaultLayout', myFusebox.getBean( 'PageService' ).getDefaultLayout() ) />

	<cfif event.valueExists( 'page_id' )>
		<cfset event.setValue( 'cfprototypenotes', myFusebox.getBean( 'NoteService' ).getNotesForPage( 	page_id = event.getValue( 'page_id' ), is_completed = event.getValue( 'is_completed', 'N' ) ) ) />
		<cfset myFusebox.variables().content.cfprototypenotes = myFusebox.do( action = 'vcfprototype.dsp_cfprototypenotes', returnOutput = true ) />
	</cfif>
	<cfset myFusebox.variables().content.pageContent = myFusebox.do( action = 'vcfprototype.dsp_pagecontent', returnOutput = true ) />
	<cfset myFusebox.variables().content.sitelayout = myFusebox.do( action = 'vcfprototype.dsp_sitelayout', returnOutput = true ) />
	<cfset myFusebox.do( action = 'vcfprototype.lay_cfprototype' ) />
</cffunction>

<cffunction name="rss" returntype="void" access="public" output="true" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset event.setValue( 'xmlData', myFusebox.getBean( 'RSSService' ).generateRSS() ) />
	<cfset myFusebox.do( action = 'vcfprototype.lay_xml' ) />
</cffunction>

</cfcomponent>