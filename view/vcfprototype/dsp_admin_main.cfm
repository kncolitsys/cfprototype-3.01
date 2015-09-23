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

<!----
<label for="first_name">First Name:</label><input id="first_name" name="first_name" value="#{firstname}" class="small"><br>
<label for="last_name">Last Name:</label><input id="last_name" name="last_name" value="#{lastname}" class="small"><br>
<label for="email">Email:</label><input id="email" name="email" value="#{email}" class="small"><br>
<label for="username">Username:</label><input id="username" name="username" value="#{username}" class="small"><br>
<label for="password">Password:</label><input type="password" id="password" name="password" value="#{password}" class="small"><br>
<label for="is_active">Is Active:</label><input type="checkbox" id="is_active" name="is_active" class="checkbox" #{isactive}><br>
<label for="is_admin">Is Admin:</label><input type="checkbox" id="is_admin" name="is_admin" class="checkbox" #{isadmin}><br>
<label for="is_notify">Email Notification:</label><input type="checkbox" id="is_notify" name="is_notify" class="checkbox" #{isnotify}><br>
<input type="hidden" name="user_id" value="#{userid}" />
<label for="kludge">&nbsp;</label><input type="submit" value="Save" name="submit" class="button" /> <input type="button" value="Cancel" name="cancel" class="button" /><br />


<label for="first_name">First Name:</label><input id="first_name" name="first_name" value="#{firstname}" class="small"><br><label for="last_name">Last Name:</label><input id="last_name" name="last_name" value="#{lastname}" class="small"><br><label for="email">Email:</label><input id="email" name="email" value="#{email}" class="small"><br><label for="username">Username:</label><input id="username" name="username" value="#{username}" class="small"><br><label for="password">Password:</label><input type="password" id="password" name="password" value="#{password}" class="small"><br><label for="is_active">Is Active:</label><input type="checkbox" id="is_active" name="is_active" class="checkbox" #{isactive}><br><label for="is_admin">Is Admin:</label><input type="checkbox" id="is_admin" name="is_admin" class="checkbox" #{isadmin}><br><label for="is_notify">Email Notification:</label><input type="checkbox" id="is_notify" name="is_notify" class="checkbox" #{isnotify}><br><input type="hidden" name="user_id" value="#{userid}" /><label for="kludge">&nbsp;</label><input type="submit" value="Save" name="submit" class="button" /> <input type="button" value="Cancel" name="cancel" class="button" /><br />

---->
<cfsilent>
<cfset qUsers = event.getValue( 'qUsers' ) />
</cfsilent>
<cfsavecontent variable="js_css">
<script src="view/_js/user.js" type="text/javascript"></script>
<script src="view/_js/usertemplate.js" type="text/javascript"></script>
<script src="view/_js/userevent.js" type="text/javascript"></script>			
<script type="text/javascript">
document.observe("dom:loaded", function(){
	var users = new User( '<cfoutput>#event.getValue( 'usersJSON' )#</cfoutput>'.evalJSON() );
	var userTemplate = new UserTemplate( '<cfoutput>#mySelf##xfa.saveUser#</cfoutput>', users );
	var userEvent = new UserEvent( userTemplate, users, '<cfoutput>#mySelf##xfa.deleteuser#</cfoutput>' );
});
</script>
</cfsavecontent>
<cfhtmlhead text="#js_css#" />
<cfoutput>
<div class="lighter-box" id="cfprototype-users">
<h2>User List</h2>	
<div id="message"></div>
<table id="usertable">
	<thead>
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Email</th>
			<th>Is Active?</th>
			<th>Is Admin?</th>
			<th>Notify?</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<cfloop query="qUsers">
			<tr id="user_#id#">
				<td>#first_name#</td>
				<td>#last_name#</td>
				<td>#email#</td>
				<td class="center">#is_active#</td>
				<td class="center">#is_admin#</td>
				<td class="center">#is_notify#</td>
				<td><a class="edit-user nolink">Edit</a><cfif username NEQ 'admin'>| <a class="delete-user nolink">Delete</a></cfif></td>
			</tr>
		</cfloop>
	</tbody>
	<tfoot id="newuser">
		<tr>
			<td colspan="7">
				<a class="nolink add-user">Add User</a>
			</td>
		</tr>
	</tfoot>
</table>
<br />
<br />
</div>
</cfoutput>