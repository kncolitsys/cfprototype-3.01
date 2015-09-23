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
</cfsilent>
<cfcontent reset="true" />
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>CFProtptype Admin</title>
	<link rel="stylesheet" type="text/css" href="view/_css/cfprototype_admin.css" media="screen" />
	<script type="text/javascript" src="view/_js/prototype.js"></script>
	<script type="text/javascript" src="view/_js/ajaxhelper.js"></script>
</head>
<cfoutput>
<body>
	<div id="servericon"><img usemap="##rc" src="view/_image/dev-corner.gif" class="servericon" /></div>	
	<!--- Header --->
	<div id="header">
		<h1>CFPrototype Admin</h1>
    </div>
	
	<!--- Side Bar --->
	<cfif StructKeyExists( content, 'sidebar' )>
		<div id="side-bar">
			#content.sidebar.trim()#
	    </div>
	</cfif>
	
	
	<!--- Main Content --->
	<div id="main">
		#content.pageContent.trim()#	
	</div>
	
	
</body>
</cfoutput>
</html>
</cfoutput>