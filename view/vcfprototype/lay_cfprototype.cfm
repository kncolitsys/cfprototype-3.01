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
<cfparam name="content.sitelayout" type="string" />
</cfsilent>
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>	
#Trim( ReReplaceNoCase( content.sitelayout, '\[HEAD\](.+)\[/HEAD\](.*)' , '\1' ) )#
<cfif StructKeyExists( content, 'cfprototypenotes' )>
	<link rel="stylesheet" type="text/css" href="view/_css/cfprototype_note.css" media="screen" />
	<script src="view/_js/prototype.js" type="text/javascript"></script>
	<script src="view/_js/notetemplate.js" type="text/javascript"></script>
	<script src="view/_js/noteevent.js" type="text/javascript"></script>
	<script type="text/javascript">
	document.observe("dom:loaded", function(){
		var notetemplate = new NoteTemplate( <cfoutput>'#event.getValue( "root_note_id" )#', '#mySelf##xfa.insert#', '#event.getValue( "isAdmin" )#'</cfoutput>);
		var noteevent = new NoteEvent( notetemplate, <cfoutput>'#event.getValue( "root_note_id" )#', '#mySelf##xfa.delete#','#mySelf##xfa.complete#'</cfoutput> );
		
	});
	</script>
</cfif>
</head>
<body>
	<div id="servericon"><img usemap="##rc" src="view/_image/dev-corner.gif" class="servericon" /></div>
#Trim( ReReplaceNoCase( content.sitelayout, '(.+)\[BODY\](.+)?\[/BODY\]' , '\2' ) )#
<cfif StructKeyExists( content, 'cfprototypenotes' )>
<hr />
<div id="cfprototypenotes">
	#Trim( content.cfprototypenotes )#
</div>
</cfif>
</body>
</html>
</cfoutput>
