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
<cfcomponent output="false" displayname="UserService" hint="" extends="AbstractService">

<cffunction name="init" returntype="UserService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="list" returntype="query" access="public" output="false" hint="">
	<cfreturn getUserDAO().list() />
</cffunction>

<cffunction name="deleteUser" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="user_id" type="numeric" required="true" hint="" />
	<cfset getUserDAO().delete( arguments.user_id  ) />
	<cfreturn arguments.user_id />
</cffunction>

<cffunction name="saveUser" returntype="any" access="public" output="false" hint="">
	<cfargument name="user_id" type="numeric" required="true" hint="" />
	<cfargument name="first_name" type="string" required="true" hint="" />
	<cfargument name="last_name" type="string" required="true" hint="" />
	<cfargument name="email" type="string" required="true" hint="" />
	<cfargument name="username" type="string" required="true" hint="" />
	<cfargument name="password" type="string" required="true" hint="" />
	<cfargument name="is_admin" type="string" required="true" hint="" />
	<cfargument name="is_active" type="string" required="true" hint="" />
	<cfargument name="is_notify" type="string" required="true" hint="" />
	<cfif arguments.user_id EQ 0>
		<cfset arguments.user_id = getUserDAO().create( argumentCollection = arguments  ) />
	<cfelse>
		<cfset getUserDAO().update( argumentCollection = arguments ) />
	</cfif>
	<cfreturn getUDF().queryRowToStruct( getUserDAO().read( arguments.user_id ) ) />
</cffunction>

<cffunction name="createAdmin" returntype="void" access="public" output="false" hint="">
	<cfif NOT hasAdminUser()>
		<cfset getUserDAO().create(	username = 'admin',
									password = 'password',
									is_admin = 'Y' ) />
	</cfif>
</cffunction>


<!--- PRIVATE METHODS --->
<cffunction name="hasAdminUser" returntype="boolean" access="private" output="false" hint="">
	<cfreturn getUserDAO().read( username = 'admin' ).recordcount GT 0 />
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getUserDAO" access="public" returntype="UserDAO" output="false" hint="Getter for UserDAO">
	<cfreturn variables.instance.UserDAO />
</cffunction>

<cffunction name="setUserDAO" access="public" returntype="void" output="false" hint="Setter for UserDAO">
	<cfargument name="UserDAO" type="UserDAO" required="true" />
	<cfset variables.instance.UserDAO = arguments.UserDAO>
</cffunction>



</cfcomponent>