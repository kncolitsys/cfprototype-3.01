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
<cfcomponent output="false" displayname="PageDAO" hint="" extends="AbstractDAO">

<cffunction name="init" returntype="PageDAO" output="false" access="public" hint="Constructor">
	<cfreturn super.init( argumentCollection = arguments ) />
</cffunction>

<!--- PACKAGE METHODS --->
<cffunction name="create" returntype="numeric" access="public" output="false" hint="">
	<cfargument name="page_name" type="string" required="false" hint="" />
	<cfset var nextId = 0 />
	<cfset var dsn = getDSN() />
	<cftransaction>
	<cfset nextId = getNextID( 'cfp_page' ) />	
		
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		INSERT INTO cfp_page
		(
			id
			, page_name
			, prototype_id
		)
		VALUES
		(
			<cfqueryparam value="#nextId#" cfsqltype="cf_sql_integer" />
			, <cfqueryparam value="#arguments.page_name#" cfsqltype="cf_sql_varchar" />
			, <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
		)
	</cfquery>
	</cftransaction>
	<cfreturn nextID />
</cffunction>

<cffunction name="read" returntype="query" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="false" hint="" />
	<cfargument name="page_name" type="string" required="false" hint="" />
	<cfset var qRead = '' />
	<cfquery name="qRead" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT	*
		FROM	cfp_page
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				<cfif StructKeyExists( arguments, 'page_id' )>
					AND id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				</cfif>
				<cfif StructKeyExists( arguments, 'page_name' )>
					AND page_name = <cfqueryparam value="#arguments.page_name#" cfsqltype="cf_sql_varchar" />
				</cfif>
	</cfquery>
	<cfreturn qRead />
</cffunction>

<cffunction name="list" returntype="query" access="package" output="false" hint="">
	<cfset var qList = '' />
	<cfquery name="qList" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT	p.*
				, ( SELECT COUNT(*) - 1 FROM cfp_note n WHERE n.page_id = p.id ) AS totalNotes 
		FROM	cfp_page p
		WHERE	p.prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
		ORDER BY p.page_name
	</cfquery>
	<cfreturn qList />
</cffunction>

<cffunction name="getPageName" returntype="string" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="false" hint="" />
	<cfreturn read( page_id = arguments.page_id ).page_name />
</cffunction>

<cffunction name="delete" returntype="void" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfset var dsn = getDSN() />
	<cftransaction>
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		DELETE
		FROM	cfp_note
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
	</cfquery>	
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		DELETE
		FROM	cfp_page
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
	</cfquery>
	</cftransaction>
</cffunction>

<!--- PRIVATE METHODS --->



<!--- GETTER & SETTER --->
</cfcomponent>