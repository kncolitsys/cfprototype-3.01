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
<cfsilent>
<cfscript>	
COLDSPRING_FACTORY_NAME = 'servicefactory';
defaultProp = StructNew();
defaultProp.applicationURL = 'http://';
if ( getPageContext().getRequest().isSecure() ){
	defaultProp.applicationURL = 'https://';
}	
defaultProp.applicationURL = defaultProp.applicationURL & getPageContext().getRequest().getServerName();
if ( getPageContext().getRequest().getServerPort() neq '80' ){
	defaultProp.applicationURL = applicationURL &  ':' & getPageContext().getRequest().getServerPort();
}	
defaultProp.applicationURL = defaultProp.applicationURL & ListDeleteAt( getPageContext().getRequest().getRequestURI(), ListLen( getPageContext().getRequest().getRequestURI(), '/' ) , '/') & '/index.cfm';
serviceFactory = CreateObject( 'component','coldspring.beans.DefaultXmlBeanFactory').init( defaultProperties = defaultProp );
serviceFactory.loadBeansFromXMLFile( beanDefinitionFile = '/cfprototype/config/coldspring.xml' );
myFusebox.getApplicationData().put( 'COLDSPRING_FACTORY_NAME', COLDSPRING_FACTORY_NAME );
myFusebox.getApplicationData().put( COLDSPRING_FACTORY_NAME, serviceFactory );
//dump( serviceFactory.getBean( 'UserService' )  );
/*
applicationURL = 'http://';
if ( getPageContext().getRequest().isSecure() ){
	applicationURL = 'https://';
}	
applicationURL = applicationURL & getPageContext().getRequest().getServerName();
if ( getPageContext().getRequest().getServerPort() neq '80' ){
	applicationURL = applicationURL &  ':' & getPageContext().getRequest().getServerPort();
}	
applicationURL = applicationURL & ListDeleteAt( getPageContext().getRequest().getRequestURI(), ListLen( getPageContext().getRequest().getRequestURI(), '/' ) , '/');
CFPROTOTYPE_SETTINGS[ 'applicationURL' ] = applicationURL & '/index.cfm';
services  = StructNew();
services['config'] = CreateObject( 'component', 'model.com.cfprototype.Config' ).init( CFPROTOTYPE_SETTINGS );
services['json'] = CreateObject( 'component', 'model.com.cfprototype.json' ).init();
services['udf'] = CreateObject( 'component', 'model.com.cfprototype.UDF' ).init();
services['NoteDAO'] = CreateObject( 'component', 'model.com.cfprototype.NoteDAO' ).init( CFPROTOTYPE_DATASOURCE );
services['PageDAO'] = CreateObject( 'component', 'model.com.cfprototype.PageDAO' ).init( CFPROTOTYPE_DATASOURCE );
services['UserDAO'] = CreateObject( 'component', 'model.com.cfprototype.UserDAO' ).init( CFPROTOTYPE_DATASOURCE );
services['NoteService'] = CreateObject( 'component', 'model.com.cfprototype.NoteService' ).init();
services['PageService'] = CreateObject( 'component', 'model.com.cfprototype.PageService' ).init();
services['RSSService'] = CreateObject( 'component', 'model.com.cfprototype.RSSService' ).init();
services['SecurityService'] = CreateObject( 'component', 'model.com.cfprototype.SecurityService' ).init();
services['UserService'] = CreateObject( 'component', 'model.com.cfprototype.UserService' ).init();
//dependencies possibly a good candidate for ColdSpring.
services['UserDAO'].setConfig( services['config'] );
services['NoteDAO'].setConfig( services['config'] );
services['PageDAO'].setConfig( services['config'] );
services['NoteService'].setConfig( services['config'] );
services['NoteService'].setNoteDAO( services['NoteDAO'] );
services['NoteService'].setUserDAO( services['UserDAO'] );
services['NoteService'].setSecurityService( services['SecurityService'] );
services['NoteService'].setUDF( services['udf'] );
services['PageService'].setConfig( services['config'] );
services['PageService'].setPageDAO( services['PageDAO'] );
services['PageService'].setNoteService( services['NoteService'] );
services['RSSService'].setConfig( services['config'] );
services['RSSService'].setNoteDAO( services['NoteDAO'] );
services['RSSService'].configure();
services['SecurityService'].setUserDAO( services['UserDAO'] );
services['SecurityService'].setUDF( services['udf'] );
services['UserService'].setUserDAO( services['UserDAO'] );
services['UserService'].setConfig( services['config'] );
services['UserService'].setUDF( services['udf'] );
myFusebox.getApplicationData().put( 'services' , services );
*/
</cfscript>		
</cfsilent>
<cffunction name="dump" returntype="void" access="package" output="false" hint="">
	<cfdump var="#arguments#"><cfabort>
</cffunction>
