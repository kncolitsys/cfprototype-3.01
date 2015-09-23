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
<cfcomponent output="false" displayname="testUserService" hint="" extends="cfprototype._tests.unit.CFUnitBase">

<cfset configure() />

<cffunction name="configure" returntype="void" access="private" output="false" hint="">
	<cfset var q = ''/>
	<cfset super.configure() />
	<cfset q = executeSQL( 'SELECT MAX( id ) AS nextID FROM cfp_user' ) />
	<cfset variables._userService =  getBean( 'UserService' ) />
	<cfset variables._testUserID = q.nextID + 1 />
</cffunction>

<cffunction name="setUp" returntype="void" access="public" output="false" hint="">
	<cfset insertTestUser() />
</cffunction>

<cffunction name="tearDown" returntype="void" access="public" output="false" hint="">
	<cfset deleteTestUser() />
</cffunction>

<cffunction name="testList" returntype="void" access="public" output="false" hint="">
	<cfset var baselineFile = variables._baselineFolder &  getName() & '.list.wddx' />
	<cfset var actual = variables._userService.list() />
	<cfset var expected = '' />
	<cfif variables._createBaseline>
		<cfset variables._testUDF.writeBaseline( baselineFile, actual ) />
	</cfif>
	<cfset assertEquals( 	actual = actual, 
							expected = variables._testUDF.readBaseline( baselineFile ),
							message = 'list method failed' ) />
</cffunction>

<cffunction name="testDeleteUser" returntype="void" access="public" output="false" hint="">
	<cfset variables._userService.deleteUser( user_id = variables._testUserID ) />
	<cfset assertTrue( condition = readTestUser( false ).recordcount EQ 0, message = 'deleteUser method failed.' )>
</cffunction>

<cffunction name="testSaveUser" returntype="void" access="public" output="false" hint="">
	<cfset var existingUser = readTestUser() />
	<cfset var changedUser = '' />
	<cfset existingUser.email = 'CHANGED' />
	<cfset changedUser = variables._userService.saveUser( 	user_id = existingUser.id,
															first_name = existingUser.first_name,
															last_name = existingUser.last_name,
															email = existingUser.email,
															username = existingUser.username,
															password = existingUser.password,
															is_admin = existingUser.is_admin,
															is_active = existingUser.is_active,
															is_notify = existingUser.is_notify							
															 ) />										 
	<cfset assertEquals( 	actual = changedUser, 
							expected = existingUser,
							message = 'saveUser method failed' ) />
</cffunction>

<cffunction name="testVarScope" returntype="void" access="public" output="false">
	<cfset super.varScopeChecker( 'UserService.cfc' ) />
</cffunction>

<cffunction name="deleteTestUser" returntype="void" access="private" output="false" hint="">
	<cfset executeSQL( 'DELETE FROM cfp_user WHERE id = #variables._testUserID#' ) />
</cffunction>

<cffunction name="insertTestUser" returntype="void" access="private" output="false" hint="">
	<cfset executeSQL( "INSERT INTO cfp_user VALUES( #variables._testUserID#, 'unitTestUser', 'unitTestUser', 'unitTestUser', 'Y', '#variables._prototypeID#', 'unitTestUser', 'unitTestUser', 'Y', 'Y' )" ) />
</cffunction>

<cffunction name="readTestUser" returntype="any" access="private" output="false" hint="">
	<cfargument name="makeStruct" type="boolean" default="true" hint="" />
	<cfset var ret = executeSQL( 'SELECT * FROM cfp_user WHERE id = #variables._testUserID#' ) />
	<cfif arguments.makeStruct>
		<cfset ret = variables._testUDF.queryRowToStruct( ret ) />
	</cfif>
	<cfreturn ret />
</cffunction>

</cfcomponent>

		