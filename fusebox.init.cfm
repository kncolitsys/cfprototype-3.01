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
<cffunction name="getBean" returntype="any" output="false" access="public" hint="">
	<cfargument name="bean" type="string" required="true" />
	<cfreturn getApplicationData().get( getApplicationData().get( 'COLDSPRING_FACTORY_NAME' ) ).getBean( arguments.bean ) />
</cffunction>
<!--- a hack to copy this method in the myFusebox component so that it is available in controllers. --->
<cfset myFusebox.getBean = getBean />	
<cfset event.setValue( 'self', myFusebox.getSelf() ) />
<cfset event.setValue( 'mySelf', myFusebox.getMySelf() ) />
<cfset self = myFusebox.getSelf() />
<cfset mySelf = myFusebox.getMySelf() />
<cfset content = StructNew() />
</cfsilent>