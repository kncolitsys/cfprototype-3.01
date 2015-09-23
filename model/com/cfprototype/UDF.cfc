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
<cfcomponent output="false" displayname="UDF" hint="">

<cffunction name="init" returntype="UDF" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="queryRowToStruct" returntype="struct" access="public" output="false" hint="">
	<cfargument name="query" type="query" required="true" hint="" />
	<cfargument name="row" type="numeric" default="1" hint="row of the query, default is 1" />
	<cfset var i =  "" />
	<cfset var retStruct = StructNew() />
	<cfset var cols = ListToArray( arguments.query.columnlist ) />
	<cfloop from="1" to="#ArrayLen( cols )#" index="i">
		<cfif isDate( arguments.query[cols[i]][arguments.row] )>
			<cfset retStruct[cols[i]] = DateFormat( arguments.query[cols[i]][arguments.row], 'mm-dd-yyyy' ) />	
		<cfelse>
			<cfset retStruct[cols[i]] = Trim( arguments.query[cols[i]][arguments.row] ) />	
		</cfif>
		
	</cfloop>
	<cfreturn retStruct />
</cffunction>
<!--- PRIVATE METHODS --->

<!--- GETTER & SETTER --->
</cfcomponent>