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
<cfset qAllPages = event.getValue( 'qAllPages' ) />
</cfsilent>
<cfsavecontent variable="js_css">
<script src="view/_js/pageevent.js" type="text/javascript"></script>		
<script type="text/javascript">
document.observe("dom:loaded", function(){
	var pageEvent = new PageEvent( <cfoutput>'#mySelf##xfa.deletepage#'</cfoutput>);
});
</script>
</cfsavecontent>
<cfhtmlhead text="#js_css#" />
<cfoutput>
<div class="lighter-box">
	<h2>Existing Pages</h2>
	<table id="pagestable">
		<tr>
			<th>Page Name</th>
			<th>Total Notes</th>
			<th>&nbsp;</th>
		</tr>
		<cfloop query="qAllPages">
			<tr id="page_#id#">
				<td>#page_name#</td>
				<td class="center">#totalNotes#</td>
				<td><a href="#mySelf##xfa.prototype#&page=#URLEncodedFormat( page_name )#">View</a> | <a class="nolink delete-page">Delete</a></td>
			</tr>
		</cfloop>
	</table>
	<br />
</div>
</cfoutput>