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
<cfcomponent output="false" displayname="AbstractDAO" hint="">

<cffunction name="init" returntype="AbstractDAO" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->

<!--- PRIVATE METHODS --->
<cffunction name="getPrototypeName" returntype="string" access="private" output="false" hint="">
	<cfreturn getConfig().get( 'prototypeName' ) />
</cffunction>

<cffunction name="isNull" returntype="boolean" access="private" output="false" hint="">
	<cfargument name="value" type="string" required="true" hint="" />
	<cfreturn NOT Len( Trim( arguments.value ) ) />
</cffunction>

<cffunction name="getNextID" returntype="numeric" access="private" output="false" hint="">
	<cfargument name="tableName" type="string" required="true" hint="" />
	<cfset var qRead = '' />
	<cfquery name="qRead" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT	MAX( id ) AS nextID
		FROM	#arguments.tableName#
	</cfquery>	
	<cfif Len( Trim( qRead.nextID ) ) AND IsNumeric( qRead.nextID )>
		<cfreturn qRead.nextID + 1 />
	</cfif>
	<cfreturn 1 />
</cffunction>

<!--- GETTER & SETTER --->
<cffunction name="getDSN" access="public" returntype="struct" output="false" hint="Getter for DSN">
	<cfreturn variables.instance.DSN />
</cffunction>

<cffunction name="setDSN" access="public" returntype="void" output="false" hint="Setter for DSN">
	<cfargument name="DSN" type="struct" required="true" />
	<cfset variables.instance.DSN = arguments.DSN>
</cffunction>

<cffunction name="getConfig" access="public" returntype="struct" output="false" hint="Getter for Config">
	<cfreturn variables.instance.Config />
</cffunction>

<cffunction name="setConfig" access="public" returntype="void" output="false" hint="Setter for Config">
	<cfargument name="config" type="struct" required="true" />
	<cfset variables.instance.Config = arguments.Config>
</cffunction>

</cfcomponent>