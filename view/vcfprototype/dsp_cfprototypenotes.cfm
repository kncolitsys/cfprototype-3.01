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
<cfset cfprototypenotes = event.getValue( 'cfprototypenotes' )>
<cfoutput>
<div id="cfprototype-admin">	
	<cfif event.getValue( 'isLoggedIn' )>
		<a href="#mySelf##xfa.logout#">Logout</a>
		<a href="#mySelf##xfa.rss#">RSS</a>
		<cfif event.getValue( 'isAdmin' )>
			<a href="#mySelf##xfa.admin#">Administration</a>
		</cfif>
	</cfif>
	<br class="clear" />		
</div>
<div id="cfprototype-message"></div>	
<div id="cfprototype-notes">#cfprototypenotes#</div>
<br />
If you have a <strong>new</strong> question or comment about this page,
please enter it below:
<form name="noteform" method="post" action="#mySelf##xfa.insert#&uri=#CreateUUID()#" class="noteform" id="newnoteform">
	<textarea cols="40" rows="10" name="note_text" wrap="soft"></textarea>
	<br />
	<input type="hidden" name="parent_id" value="#event.getValue( 'root_note_id' )#" />
	<input type="submit" value="Submit" class="devnotesubmit" />
</form>

</cfoutput>