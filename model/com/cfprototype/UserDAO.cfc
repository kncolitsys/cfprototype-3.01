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
<cfcomponent output="false" displayname="UserDAO" hint="" extends="AbstractDAO">

<cffunction name="init" returntype="UserDAO" output="false" access="public" hint="Constructor">
	<cfreturn super.init( argumentCollection = arguments ) />
</cffunction>

<!--- PACKAGE METHODS --->
<cffunction name="getPrototypeRecipients" returntype="string" access="package" output="false" hint="">
	<cfargument name="poster_id" type="numeric" required="false" hint="" />
	<cfset var qPrototypeRecipients = '' />
	<cfquery name="qPrototypeRecipients" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT	email
		FROM	cfp_user
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				<cfif StructKeyExists( arguments, 'poster_id' )>
					AND id <> <cfqueryparam value="#arguments.poster_id#" cfsqltype="cf_sql_integer" />
				</cfif>
	</cfquery>
	<cfreturn ValueList( qPrototypeRecipients.email ) />
</cffunction>

<cffunction name="list" returntype="query" access="package" output="false" hint="">
	<cfset var qList = '' />
	<cfquery name="qList" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT	*
		FROM	cfp_user
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
		ORDER BY last_name
	</cfquery>
	<cfreturn qList />
</cffunction>

<cffunction name="update" returntype="void" access="package" output="false" hint="">
	<cfargument name="user_id" type="string" required="true" hint="" />
	<cfargument name="username" type="string" required="true" hint="" />
	<cfargument name="password" type="string" required="true" hint="" />
	<cfargument name="first_name" type="string" default="#arguments.username#" hint="" />
	<cfargument name="last_name" type="string" default="#arguments.username#" hint="" />
	<cfargument name="email" type="string" default="#arguments.username#" hint="" />
	<cfargument name="is_admin" type="string" default="Y" hint="" />
	<cfargument name="is_active" type="string" default="Y" hint="" />
	<cfargument name="is_notify" type="string" default="N" hint="" />
	<cfset var dsn = getDSN() />
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		UPDATE	cfp_user
		SET		first_name = <cfqueryparam value="#arguments.first_name#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.first_name )#" />
				, last_name = <cfqueryparam value="#arguments.last_name#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.last_name )#" />
				, username = <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.username )#" />
				, password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.password )#" />
				, email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.email )#" />
				, is_admin = <cfqueryparam value="#arguments.is_admin#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.is_admin )#" />
				, is_active = <cfqueryparam value="#arguments.is_active#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.is_active )#" />
				, is_notify = <cfqueryparam value="#arguments.is_notify#" cfsqltype="cf_sql_varchar" null="#isNull( arguments.is_notify )#" />
		WHERE	id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_varchar" />
				AND prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
	</cfquery>
</cffunction>

<cffunction name="create" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="username" type="string" required="true" hint="" />
	<cfargument name="password" type="string" required="true" hint="" />
	<cfargument name="first_name" type="string" default="#arguments.username#" hint="" />
	<cfargument name="last_name" type="string" default="#arguments.username#" hint="" />
	<cfargument name="email" type="string" default="#arguments.username#" hint="" />
	<cfargument name="is_admin" type="string" default="Y" hint="" />
	<cfargument name="is_active" type="string" default="Y" hint="" />
	<cfargument name="is_notify" type="string" default="N" hint="" />
	<cfset var dsn = getDSN() />
	<cfset var nextID = '' />
	<cftransaction>
	<cfset nextID = getNextID( 'cfp_user' ) />
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		INSERT INTO cfp_user
		(
			id
			, first_name
			, last_name
			, username
			, password
			, email
			, is_admin
			, is_active
			, is_notify
			, prototype_id
		)
		VALUES
		(
			<cfqueryparam value="#nextID#" cfsqltype="cf_sql_varchar" />
			, <cfqueryparam value="#arguments.first_name#" cfsqltype="cf_sql_varchar" />
			, <cfqueryparam value="#arguments.last_name#" cfsqltype="cf_sql_varchar"  />
			, <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar"  />
			, <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar"  />
			, <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar"  />
			, <cfqueryparam value="#arguments.is_admin#" cfsqltype="cf_sql_char"  />
			, <cfqueryparam value="#arguments.is_active#" cfsqltype="cf_sql_char"  />
			, <cfqueryparam value="#arguments.is_notify#" cfsqltype="cf_sql_char" />
			, <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
		)
	</cfquery>
	</cftransaction>
	<cfreturn nextID />
</cffunction>

<cffunction name="read" returntype="query" access="package" output="false" hint="">
	<cfargument name="user_id" type="string" required="false" hint="" />
	<cfargument name="username" type="string" required="false" hint="" />
	<cfargument name="password" type="string" required="false" hint="" />
	<cfargument name="is_active" type="string" required="false" hint="" />
	<cfset var qRead = '' />
	<cfquery name="qRead" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT	*
		FROM	cfp_user
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				<cfif StructKeyExists( arguments, 'username' )>
					AND username = <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar" />
				</cfif>
				<cfif StructKeyExists( arguments, 'password' )>
					AND password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar" />
				</cfif>
				<cfif StructKeyExists( arguments, 'user_id' )>
					AND id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer" />
				</cfif>
				<cfif StructKeyExists( arguments, 'is_active' )>
					AND is_active = <cfqueryparam value="#arguments.is_active#" cfsqltype="cf_sql_char" />
				</cfif>
	</cfquery>
	<cfreturn qRead />
</cffunction>

<cffunction name="delete" returntype="void" access="package" output="false" hint="">
	<cfargument name="user_id" type="numeric" required="true" hint="" />
	<cfset var dsn = getDSN() />
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		DELETE
		FROM	cfp_user
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cffunction>
<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->

</cfcomponent>