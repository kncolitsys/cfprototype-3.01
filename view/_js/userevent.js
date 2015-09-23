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
var UserEvent = Class.create({
	initialize : function(template, users, xfadelete){
		this.template = template;
		this.users = users;
		this.xfadelete = xfadelete;
		this.usertable = 'usertable';
		this.cancel = 'input.cancel-user';
		this.edit = 'a.edit-user';
		this.nolink = 'a.nolink';
		this.add = 'a.add-user';
		this.newuser = 'newuser';
		this.message = $('message');
		this.delet = 'a.delete-user';
		this.userform = 'form.userform';
		this.newuserform = 'newuserform';
		
		$(this.usertable).select(this.nolink).each( function(item){
			item.writeAttribute("href",'javascript:void(0)');
		});
		
		$(this.usertable).select(this.edit).invoke( 'observe', 'click', function(event){
			event.stop();
			this.doEditUser( event.element().up('tr').id.split('_')[1] );
		}.bindAsEventListener(this));
		
		
		$(this.usertable).select(this.delet).invoke( 'observe', 'click', function(event){
			event.stop();
			this.doDeleteUser( event.element().up('tr').readAttribute('id').split('_')[1] );
		}.bindAsEventListener(this));
		
		
		this.activateAddLink();	
	},
	
	doDeleteUser : function(userid){
		var con = confirm("Are you sure?");
		if (con){
			this.emptyMessage();
			new Ajax.Request( 
				this.xfadelete,
				{
					method: 'get',
					parameters : { user_id: userid, uid : new Date().getTime() },
					onSuccess:this.afterDelete.bindAsEventListener(this)
				}
			);
		}
	},
	
	afterDelete : function(transport){
		var json = transport.responseText.evalJSON();
		if (json['VALID']==false){
			this.addErrorMessage(json['MESSAGE']);
		}
		else {
			this.getUserRow(json['DATA']).remove();
		}
	},
	
	/* add user events */
	doAddUser : function(){
		var existing = $$('table#' + this.usertable + ' ' + this.userform );
		
		//var existing = $$('table#' + this.usertable + ' ' + this.userform );
		if (existing.length > 0){
			existing.each(function(item){
				var row = item.up('tr');
				var userid = row.id.split('_')[1];
				row.replace(this.template.getEditRow(userid));
				this.activateEditLink(userid);
			}.bindAsEventListener(this));
		}
		$(this.newuser).down('tr').replace(this.template.getAddForm());
		this.activateAddForm();
	},
	
	doAddUserForm: function(form){
		this.emptyMessage();
		new Ajax.Request( 
			form.readAttribute( 'action' ),
			{
				method: 'get',
				parameters : form.serialize(),
				onSuccess:this.afterAddForm.bindAsEventListener(this)
			}
		);
	},
	
	doCancelAddForm : function(){
		$(this.newuser).down('tr').replace(this.template.getAddRow());
		this.activateAddLink();
	},
	
	activateAddForm : function(){
		var form = $(this.newuser).down('form');
		form.observe('submit', function(event){
			event.stop();
			this.doAddUserForm(event.element());
		}.bindAsEventListener(this));
		form.down(this.cancel).observe('click',function(event){
			event.stop();
			this.doCancelAddForm();
		}.bindAsEventListener(this));
	},
	
	activateAddLink : function(){
		$(this.newuser).down(this.add).observe('click', function(event){
			event.stop();
			this.doAddUser();
		}.bindAsEventListener(this));	
	},
	
	afterAddForm : function(transport){
		var json = transport.responseText.evalJSON();
		if (json['VALID']==false){
			this.addErrorMessage(json['MESSAGE']);
		}
		else {
			var user = json['DATA'];
			this.users.addUser(user);
			$(this.newuser).down('tr').remove();
			$(this.usertable).down('tbody').insert(this.template.getEditRow(user['ID']) );
			$(this.usertable).down('tfoot').insert(this.template.getAddRow());
			this.activateEditLink(user['ID']);
			this.activateAddLink();
		}
	},
	
	/* edit user events */
	doEditUser : function(userid){
		var existing = $$('table#' + this.usertable + ' ' + this.userform );
		if (existing.length > 0){
			existing.each(function(item){
				var row = item.up('tr');
				var existinguserid = row.id.split('_')[1];
				row.replace(this.template.getEditRow(existinguserid));
				this.activateEditLink(existinguserid);
			}.bindAsEventListener(this));
		}
		if ($(this.newuserform)){
			$(this.newuser).down('tr').replace(this.template.getAddRow());
			this.activateAddLink();
		}
		this.getUserRow(userid).replace(this.template.getEditForm(userid));
		this.activateEditForm(userid);
	},	
	
	doEditUserForm: function(form){
		this.emptyMessage();
		new Ajax.Request( 
			form.readAttribute( 'action' ),
			{
				method: 'get',
				parameters : form.serialize(),
				onSuccess:this.afterEditForm.bindAsEventListener(this)
			}
		);
	},
	
	doCancelEditForm : function(userid){
		var row = this.getUserRow(userid);
		row.replace(this.template.getEditRow(userid));
		this.activateEditLink(userid);
	},
	
	activateEditForm : function(userid){
		var userform = this.getUserRow(userid).down( 'form' );
		userform.observe('submit', function(event){
			event.stop();
			this.doEditUserForm(event.element());
		}.bindAsEventListener(this));
		userform.down(this.cancel).observe('click',function(event){
			event.stop();
			this.doCancelEditForm(userid);
		}.bindAsEventListener(this));
	},
	
	activateEditLink : function(userid){
		var row = this.getUserRow(userid);
		row.down(this.edit).observe('click', function(event){
			event.stop();
			this.doEditUser(userid);
		}.bindAsEventListener(this));
		if (row.down(this.delet)){
			row.down(this.delet).observe('click', function(event){
				event.stop();
				this.doDeleteUser(userid);
			}.bindAsEventListener(this));
		}

		row.getElementsBySelector(this.nolink).each( function(item){
			item.writeAttribute("href",'javascript:void(0)');
		});
	},
	
	afterEditForm : function(transport){
		var json = transport.responseText.evalJSON();
		if (json['VALID'] == false ){
			this.addErrorMessage(json['MESSAGE']);
		}
		else {
			json = json['DATA'];
			this.users.addUser(json);
			var userid = json["ID"]; 
			this.getUserRow(userid).replace(this.template.getEditRow(userid));
			this.activateEditLink(userid);
		}
		
	},
	
	getUserRow : function(userid){
		return $(this.usertable).down("tr#user_" + userid);
	},
	
	emptyMessage : function(){
		this.message.removeClassName('error-message');
		this.message.update('');
	},
	
	addErrorMessage: function(message){
		this.message.addClassName('error-message'); 
		this.message.update(message);	
	}
	
});

/*
function doEditUserForm(e,f){
		Event.stop(e);
		var pars = f.serialize();
		pars+= '&uid=' + new Date().getTime();
		new Ajax.Request( 
				f.readAttribute( 'action' ),
				{
					method: 'get',
					parameters:pars,
					onSuccess:afterEditForm
				}
			);
	}	*/