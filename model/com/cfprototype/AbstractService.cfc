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
<cfcomponent output="false" displayname="AbstractService" hint="">

<cffunction name="init" returntype="AbstractService" output="false" access="public" hint="Constructor">
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->

<!--- PRIVATE METHODS --->
<cffunction name="getPrototypeName" returntype="string" access="private" output="false" hint="">
	<cfreturn getConfig().get( 'prototypeName' ) />
</cffunction>


<!--- GETTER & SETTER --->
<cffunction name="getConfig" access="public" returntype="struct" output="false" hint="Getter for Config">
	<cfreturn variables.instance.Config />
</cffunction>

<cffunction name="setConfig" access="public" returntype="void" output="false" hint="Setter for Config">
	<cfargument name="Config" type="struct" required="true" />
	<cfset variables.instance.Config = arguments.Config>
</cffunction>

<cffunction name="getUDF" access="public" returntype="UDF" output="false" hint="Getter for UDF">
	<cfreturn variables.instance.UDF />
</cffunction>

<cffunction name="setUDF" access="public" returntype="void" output="false" hint="Setter for UDF">
	<cfargument name="UDF" type="UDF" required="true" />
	<cfset variables.instance.UDF = arguments.UDF>
</cffunction>

</cfcomponent>