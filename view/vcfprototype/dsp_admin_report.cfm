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
<cfset reportArray = event.getValue( 'reportArray' ) />
</cfsilent>
<cfoutput>
<cfloop from="1" to="#ArrayLen( reportArray )#" index="i">
	<div class="cfprototype-report-content">
		<p class="cfprototype-report-pageheader">Page: #reportArray[i].pageName#</p>
		<hr />
		#Trim( reportArray[i].pageNotes )#
	</div>	
</cfloop>
</cfoutput>
