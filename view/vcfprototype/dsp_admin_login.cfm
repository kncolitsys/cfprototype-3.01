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
<div class="lighter-box">
	<h2>Login</h2>
	<cfif event.valueExists( 'message' )>
		<br /><span class="error">#event.getValue( 'message' ).trim()#</span>
	</cfif>
	<br />
	<form id="loginForm" method="post" action="#myself##xfa.process#" class="data">
		<label for="username">Username:</label>
		<input id="username" name="username" value="#event.getValue( 'username', '' )#" class="small"><br>
	
		<label for="password">Password:</label>
		<input type="password" id="password" name="password" value="#event.getValue( 'password', '' )#" class="small"><br>
		
		<label for="submit">&nbsp;</label>
		<input id="submit" type="submit" value="Login" name="submit" class="button" /> <br />
	</form>
</div>
</cfoutput>