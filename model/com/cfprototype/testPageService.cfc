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
<cfcomponent output="false" displayname="testPageService" hint="" extends="cfprototype._tests.unit.CFUnitBase">

<cfset configure() />

<cffunction name="configure" returntype="void" access="private" output="false" hint="">
	<cfset super.configure() />
	<cfset variables._pageService = getBean( 'PageService' ) />
</cffunction>

<cffunction name="setUp" returntype="void" access="public" output="false" hint="">
	<cfset variables._testPageId = insertUnitTestPage() />
</cffunction>

<cffunction name="tearDown" returntype="void" access="public" output="false" hint="">
	<cfset deleteUnitTestPage() />
	<cfset executeSQL( "DELETE FROM cfp_page WHERE page_name = 'unit_test_for_create_page' AND prototype_id = '" & variables._prototypeID & "'" ) />
</cffunction>

<cffunction name="testVarScope" returntype="void" access="public" output="false">
	<cfset super.varScopeChecker( 'PageService.cfc' ) />
</cffunction>

<cffunction name="testGetDefaultLayout" returntype="void" access="public" output="false" hint="">
	<cfset assertEquals( 	actual = variables._pageService.getDefaultLayout(), 
							expected = 'lay_template',
							message = 'getDefaultLayout method failed' ) />
</cffunction>

<cffunction name="testCreatePage" returntype="void" access="public" output="false" hint="">
	<cfset var q = '' />
	<cfset variables._pageService.createPage( page = 'unit_test_for_create_page') />
	<cfset q = executeSQL( "SELECT * FROM cfp_page WHERE page_name = 'unit_test_for_create_page' AND prototype_id = '" & variables._prototypeID & "'" ) />
	<cfset assertTrue( condition = q.recordcount GT 0, message = 'createPage method failed to add a new page name "unit_test_for_create_page" to the database.' ) />
</cffunction>

<cffunction name="testGetPageId" returntype="void" access="public" output="false" hint="">
	<cfset assertEquals( 	actual = variables._pageService.getPageId( page = 'unit_test_page'),
							expected = variables._testPageID,
							message = 'getPageID returned invalid page id.') />
</cffunction>

<cffunction name="testGetAllPages" returntype="void" access="public" output="false" hint="">
	<cfset assertTrue( 	condition = variables._pageService.getAllPages().recordcount GT 0, 
						message = 'GetAllPages method failed.' ) />
</cffunction>

<cffunction name="testDeletePage" returntype="void" access="public" output="false" hint="">
	<cfset variables._pageService.deletePage( variables._testPageID ) />
	<cfset assertTrue( 	condition = executeSQL( "SELECT * FROM cfp_page WHERE id = #variables._testPageID# AND prototype_id = '#variables._prototypeID#'").recordcount EQ 0, 
						message = 'deletePage method failed to delete a page from the database.' ) />
</cffunction>

</cfcomponent>