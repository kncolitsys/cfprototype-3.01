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
<cfcomponent output="false">
	
	<!--- Application name, should be unique --->
	<cfset this.name = Hash( getCurrentTemplatePath() ) />
	<!--- How long application vars persist --->
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
	<!--- Where should cflogin stuff persist --->
	<cfset this.loginStorage = "session">
	<!--- Should we even use sessions? --->
	<cfset this.sessionManagement = true>
	<!--- How long do session vars persist? --->
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
	<!--- should we try to block 'bad' input from users --->
	<cfset this.scriptProtect = false />
		
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfreturn true>
	</cffunction>

	<!--- Run when application stops --->
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	<!--- Fired when user requests a CFM that doesn't exist. --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string">
		<cfreturn true>
	</cffunction>
	
	<!--- Run before the request is processed --->
	<!--- <cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		<cfreturn true>
	</cffunction> --->

	<!--- Runs before request as well, after onRequestStart --->
	<!--- <cffunction name="onRequest" returnType="void">
		<cfargument name="thePage" type="string" required="true">
		<cfinclude template="#arguments.thePage#">
	</cffunction> --->

	<!--- Runs at end of request --->
	<cffunction name="onRequestEnd" returnType="void" output="false">
		<cfargument name="thePage" type="string" required="true">
	</cffunction>

	<!--- Runs on error --->
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cfdump var="#arguments#"><cfabort>
	</cffunction>

	<!--- Runs when your session starts --->
	<cffunction name="onSessionStart" returnType="void" output="false">
	</cffunction>

	<!--- Runs when session ends --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>
</cfcomponent>