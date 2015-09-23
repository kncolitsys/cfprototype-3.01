/*
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
*/
var UserTemplate = Class.create( {
	initialize : function(savexfa,users){
		this.users = users;
		this.template = {
							editform : new Template('<tr id="user_#{userid}"><td colspan="7"><form class="userform" name="userform" method="post" action="' + savexfa + '&uid=#{uid}"><label for="first_name">First Name:</label><input id="first_name" name="first_name" value="#{firstname}" class="small"><br><label for="last_name">Last Name:</label><input id="last_name" name="last_name" value="#{lastname}" class="small"><br><label for="email">Email:</label><input id="email" name="email" value="#{email}" class="small"><br><label for="username">Username:</label><input id="username" name="username" value="#{username}" class="small"><br><label for="password">Password:</label><input type="password" id="password" name="password" value="#{password}" class="small"><br><label for="is_active">Is Active:</label><input type="checkbox" id="is_active" name="is_active" value="Y" class="checkbox" #{isactive}><br><label for="is_admin">Is Admin:</label><input type="checkbox" id="is_admin" name="is_admin" value="Y" class="checkbox" #{isadmin}><br><label for="is_notify">Email Notification:</label><input type="checkbox" id="is_notify" value="Y" name="is_notify" class="checkbox" #{isnotify}><br><input type="hidden" name="user_id" value="#{userid}" /><label for="kludge">&nbsp;</label><input type="submit" value="Save" name="submit" class="button" /> <input type="button" value="Cancel" name="cancel" class="button cancel-user" /><br /></form></td></tr>'),
							addform : new Template('<tr><td colspan="7"><form id="newuserform" name="userform" method="post" action="' + savexfa + '&uid=#{uid}"><label for="first_name">First Name:</label><input id="first_name" name="first_name" value="" class="small"><br><label for="last_name">Last Name:</label><input id="last_name" name="last_name" value="" class="small"><br><label for="email">Email:</label><input id="email" name="email" value="" class="small"><br><label for="username">Username:</label><input id="username" name="username" value="" class="small"><br><label for="password">Password:</label><input type="password" id="password" name="password" value="" class="small"><br><label for="is_active">Is Active:</label><input type="checkbox" id="is_active" name="is_active" value="Y" class="checkbox" checked /><br><label for="is_admin">Is Admin:</label><input type="checkbox" id="is_admin" name="is_admin" value="Y" class="checkbox" checked /><br><label for="is_notify">Email Notification:</label><input type="checkbox" id="is_notify" value="Y" name="is_notify" class="checkbox" checked /><br><input type="hidden" name="user_id" value="0" /><label for="kludge">&nbsp;</label><input type="submit" value="Save" name="submit" class="button" /> <input type="button" value="Cancel" name="cancel" class="button cancel-user" /><br /></form></td></tr>'),
							editrow : new Template('<tr id="user_#{userid}"><td>#{firstname}</td><td>#{lastname}</td><td>#{email}</td><td class="center">#{isactive}</td><td class="center">#{isadmin}</td><td class="center">#{isnotify}</td><td><a class="edit-user nolink">Edit</a> | <a class="delete-user nolink">Delete</a> </td></tr>'),
							editrowadmin : new Template('<tr id="user_#{userid}"><td>#{firstname}</td><td>#{lastname}</td><td>#{email}</td><td class="center">#{isactive}</td><td class="center">#{isadmin}</td><td class="center">#{isnotify}</td><td><a class="edit-user nolink">Edit</a> </td></tr>'),
							addrow : new Template('<tr><td colspan="7"><a class="nolink add-user">Add User</a></td></tr>')
						};		
	},
	
	getEditForm : function(userid){
		var user = this.users.getUser(userid);
		return this.template['editform'].evaluate( {
													uid : new Date().getTime(),
													firstname:user.firstname,
													lastname:user.lastname,
													email:user.email,
													username:user.username,
													password:user.password,
													isactive: user.isactive == 'Y' ? 'checked': '',
													isadmin: user.isadmin == 'Y' ? 'checked': '',	
													isnotify: user.isnotify == 'Y' ? 'checked': '',
													userid: user.userid
												});
	},
	
	getEditRow : function(userid){
		var user = this.users.getUser(userid);
		var template = (user.username == 'admin') ? this.template['editrowadmin'] : this.template['editrow'];
		return template.evaluate( {
									userid:userid,
									firstname:user.firstname,
									lastname:user.lastname,
									email:user.email,
									isactive:user.isactive,
									isadmin:user.isadmin,
									isnotify:user.isnotify
							});
	},
	
	getAddForm : function(){
		return this.template['addform'].evaluate({ uid : new Date().getTime() });
	},
	
	getAddRow : function(){
		return this.template['addrow'].evaluate({});
	}
});
