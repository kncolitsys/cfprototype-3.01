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

<cfcomponent output="false" displayname="admin" hint="This is admin circuit.xml file.">

<cffunction name="prefuseaction" access="public" returntype="void" output="false" hint="normal fusebox prefuseaction.">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<!--- we will create an admin account if it doesn't exists. User can later mark this account as inactive --->
	<cfset myFusebox.getBean( 'UserService' ).createAdmin() />	
	<cfif NOT ListFindNoCase( 'login,doLogin,logout', myFusebox.originalFuseaction ) AND  NOT myFusebox.getBean( 'SecurityService' ).isLoggedIn()>
		<cfset myFusebox.relocate( 	url = myFusebox.getMyself() & 'admin.login', 
									addtoken = 'false', 
									type='client')>
	</cfif>
	<cfif myFusebox.getBean( 'SecurityService' ).isLoggedIn()>
		<cfset event.xfa( 'users', 'main') />
		<cfset event.xfa( 'report', 'report' ) />
		<cfset event.xfa( 'logout', 'logout' ) />
		<cfset event.xfa( 'pages', 'pages' ) />
		<cfset event.xfa( 'prototype', 'cfprototype.main') />
		<cfset myFusebox.variables().content.sidebar = myFusebox.do( action = 'vcfprototype.dsp_admin_sidebar', returnOutput = true ) />
	</cfif>		
</cffunction>

<cffunction name="postfuseaction" access="public" returntype="void" output="true" hint="normal fusebox postfuseaction.">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<!--- do the layout --->
	<cfset myFusebox.do( action = 'vcfprototype.lay_admin' ) />
</cffunction>
	
<cffunction name="login" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset event.xfa( 'process', 'doLogin', 'returnpage', event.getValue( 'returnpage' )) />
	<cfset myfusebox.variables().content.pageContent = myFusebox.do( action = 'vcfprototype.dsp_admin_login', returnOutput = true ) />
</cffunction>

<cffunction name="doLogin" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset var result = myFusebox.getBean( 'SecurityService' ).authenticate( username = event.getValue( 'username' ), password = event.getValue( 'password' ) ) />
	<cfset event.xfa( 'success', 'cfprototype.main',  'page', event.getValue( 'returnpage' ) ) />
	<cfset event.xfa( 'fail', 'login', 'message', 'Login failed',  'returnpage', event.getValue( 'returnpage' )  ) />		
	<cfif result>
		<cfset myFusebox.relocate( xfa =  'success', type='client' ) />
	<cfelse>
		<cfset myFusebox.relocate( xfa =  'fail', type='client' ) />	
	</cfif>
</cffunction>

<cffunction name="logout" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset myFusebox.getBean( 'SecurityService' ).logout() />
	<cfset myFusebox.relocate( 	url = 	myFusebox.getMyself() & 'admin.main', 
								addtoken = 'false', 
								type='client' ) />
</cffunction>

<cffunction name="main" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset event.xfa( 'saveuser', 'ajax.saveuser') />
	<cfset event.xfa( 'deleteuser', 'ajax.deleteuser') />
	<cfset event.setValue( 'qUsers', myFusebox.getBean( 'UserService' ).list() ) />
	<cfset event.setValue( 'usersJSON', myFusebox.getBean( 'JSON' ).encode( event.getValue( 'qUsers' ) ) ) />
	<cfset myfusebox.variables().content.pageContent = myFusebox.do( action = 'vcfprototype.dsp_admin_main', returnOutput = true ) />
</cffunction>

<cffunction name="report" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset event.setValue( 'reportArray', myFusebox.getBean( 'PageService' ).generateReport() ) />
	<cfset myfusebox.variables().content.pageContent = myFusebox.do( action = 'vcfprototype.dsp_admin_report', returnOutput = true ) />
</cffunction>
 
<cffunction name="pages" returntype="void" access="public" output="false" hint="">
	<cfargument name="myFusebox" type="any" required="true" hint="" />
	<cfargument name="event" type="any" required="true" hint="" />
	<cfset event.xfa( 'deletepage', 'ajax.deletepage') />
	<cfset event.setValue( 'qAllPages', myFusebox.getBean( 'PageService' ).getAllPages() ) />
	<cfset myfusebox.variables().content.pageContent = myFusebox.do( action = 'vcfprototype.dsp_admin_pages', returnOutput = true ) />
</cffunction>

</cfcomponent>