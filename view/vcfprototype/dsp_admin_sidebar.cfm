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
<cfoutput>
<p class="sideBarTitle">Menu</p>
<ul>
	<li><a href="#event.getValue( 'myself' )##xfa.prototype#">Back to Prototype</a></li>
	<li><a href="#event.getValue( 'myself' )##xfa.users#">Users</a></li>
	<li><a href="#event.getValue( 'myself' )##xfa.pages#">Pages</a></li>
	<!--- <li><a href="#event.getValue( 'myself' )##xfa.report#">Report</a></li> --->
	<li><a href="#event.getValue( 'myself' )##xfa.logout#">Logout</a></li>
</ul>
</cfoutput>