<!---
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

$Date: 2008-07-03 16:32:20 -0400 (Thu, 03 Jul 2008) $
$Revision: 73 $

--->

<!--- 
This will be the layout file for your application. Feel free to modify it to match your layout. 
However keep note of the following variables which are required in the template.
	[HEAD] will contain information that you will mostly be in <head> tag
	[BODY] will contain file that you will mostly be in <body> tag

content.pageContent is a variables which includes content for the page requested. 
--->
<cfsilent>
<cfparam name="content.pageContent" type="string" default="" />
</cfsilent>
<cfoutput>
[HEAD]
<title>Rasheed Consulting</title>
<link href="view/_css/rasheedconsulting.css" rel="stylesheet" type="text/css" />
[/HEAD]
[BODY]
<div id="container">
	<div id="header">
		<h1 title="rasheedconsulting.com">Rasheed Consulting</h1>
	</div>
	<ul id="nav">
		<li><a href="index.cfm?page=home" title="Home" class="on">Home</a></li>
		<li><a href="index.cfm?page=aboutus" title="Blog" class="on">About Us</a></li>
	</ul>
	<div id="sidebar">
		<div>
			<h3>Products</h3
			<p>
				<ul>
					<li><a href="##">CFDefect</a></li>
					<li><a href="##">CFPrototype</a></li>
				</ul>
			</p>
		</div>
	</div>
	<div id="content">
		#Trim( content.pageContent )#		
	</div>	
	<div id="footer">
		Copyright &copy; 2008 Rasheed Consulting. All Rights Reserved.<br />	
	</div>
</div>
[/BODY]
</cfoutput>

