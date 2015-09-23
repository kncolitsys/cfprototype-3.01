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
<cfcomponent output="false" displayname="testNoteService" hint="" extends="cfprototype._tests.unit.CFUnitBase">

<cfset configure() />

<cffunction name="configure" returntype="void" access="private" output="false" hint="">
	<cfset super.configure() />
	<cfset variables._noteService = getBean( 'NoteService' ) />
	<cfset getBean( 'SecurityService' ).mockMethod('getUserID').returns( '2','2' ) />
</cffunction>

<cffunction name="setUp" returntype="void" access="public" output="false" hint="">
	<cfset variables._testPageId = insertUnitTestPage() />
	
	<cfset getBean( 'SecurityService' ).mockMethod('isAdmin').returns( true ) />
	<cfset variables._noteService.createRootNode( variables._testPageID ) />
	<cfset variables._rootNoteID = executeSQL( "SELECT id FROM cfp_note WHERE note_text = 'root' AND page_id = #variables._testPageId# AND prototype_id = '#variables._prototypeID#'" ).id />
</cffunction>

<cffunction name="tearDown" returntype="void" access="public" output="false" hint="">
	<cfset deleteUnitTestPage() />
</cffunction>

<cffunction name="testVarScope" returntype="void" access="public" output="false">
	<cfset super.varScopeChecker( 'NoteService.cfc' ) />
</cffunction>

<cffunction name="testGetRootNoteID" returntype="void" access="public" output="false" hint="">
	<cfset assertEquals( 	actual = variables._noteService.getRootNoteID( variables._testPageId ),
							expected = variables._rootNoteID,
							message = 'GetRootNoteID method failed'		)>
</cffunction>

<cffunction name="testAddNote" returntype="void" access="public" output="false" hint="">
	<cfset var q = variables._noteService.addNote( 	page_id = variables._testPageId,
													parent_id = variables._rootNoteID,
													note_text = 'unit test add note method.' )>
	
	<cfset assertEquals( 	actual = q.page_id,
							expected = variables._testPageId,
							message = 'add note method failed as note was added to wrong page' ) />
	
	
	<cfset variables._noteService.removeNote( page_id = variables._testPageID, note_id = q.id ) />																		
</cffunction>

</cfcomponent>