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
<cfcomponent output="false" displayname="SecurityService" hint="" extends="AbstractService">

<cffunction name="init" returntype="SecurityService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="isLoggedIn" returntype="boolean" access="public" output="false" hint="">
	<cfreturn StructKeyExists( session, 'user' ) />
</cffunction>

<cffunction name="authenticate" returntype="boolean" access="public" output="false" hint="">
	<cfargument name="username" type="string" required="true" hint="" />
	<cfargument name="password" type="string" required="true" hint="" />
	<cfset var qRead = getUserDAO().read( 	username = arguments.username, 
											password = arguments.password ) />
	<cfset StructDelete( session, 'user', false ) />											
	<cfif qRead.recordcount>
		<cfset session['user'] = getUDF().queryRowToStruct( qRead ) />
		<cfreturn true />
	</cfif>											
	<cfreturn false />									
</cffunction>

<cffunction name="getUser" returntype="struct" access="public" output="false" hint="">
	<cfif isLoggedIn()>
		<cfreturn session['user'] />
	</cfif>
	<cfreturn StructNew() />
</cffunction>

<cffunction name="getUserID" returntype="numeric" access="public" output="false" hint="">
	<cfreturn getUser().id />
</cffunction>


<cffunction name="isAdmin" returntype="boolean" access="public" output="false" hint="">
	<cfif StructKeyExists( getUser(),  'is_admin' ) AND getUser().is_admin EQ 'Y'>
		<cfreturn true />
	</cfif>
	<cfreturn false />
</cffunction>

<cffunction name="logout" returntype="void" access="public" output="false" hint="">
	<cfset StructDelete( session, 'user', false ) />
</cffunction>

<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
<cffunction name="getUserDAO" access="public" returntype="UserDAO" output="false" hint="Getter for UserDAO">
	<cfreturn variables.instance.UserDAO />
</cffunction>

<cffunction name="setUserDAO" access="public" returntype="void" output="false" hint="Setter for UserDAO">
	<cfargument name="UserDAO" type="UserDAO" required="true" />
	<cfset variables.instance.UserDAO = arguments.UserDAO>
</cffunction>
</cfcomponent>