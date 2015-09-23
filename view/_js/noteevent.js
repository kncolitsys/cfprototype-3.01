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
var NoteEvent = Class.create({
	initialize : function(template, rootnoteid,xfadelete,xfacomplete){
		this.template = template;
		this.rootnoteid = rootnoteid;
		this.xfadelete = xfadelete;
		this.xfacomplete = xfacomplete;
		this.newnoteform = 'newnoteform';
		this.nolink = 'a.nolink';
		this.prototypenotes = 'cfprototype-notes';
		this.replynote = 'a.reply-note';
		this.deletenote = 'a.delete-note';
		this.completenote = 'a.complete-note';
		this.cancelnote = 'input.cancel-note';
		this.notelinks = 'div.note-links';
		this.noteformcontainer = 'div.noteform-container';
		this.cfprototypemessage = 'cfprototype-message';
		this.noteform = 'form.cfprototype-noteform';
		
		var prototypenotes = $(this.prototypenotes);
		
		$(this.newnoteform).observe( "submit", function(event){
			this.doNoteForm(event,Event.element(event));
		}.bindAsEventListener(this));
				
		prototypenotes.select(this.nolink).each( function(item){
			item.writeAttribute("href",'javascript:void(0)');
		});
		
		prototypenotes.select(this.replynote).invoke('observe','click',function(event){
			this.doNoteReply(event,Event.element(event).up().up().id.split('_')[1] );
		}.bindAsEventListener(this));	
		
		prototypenotes.select(this.deletenote).invoke('observe','click',function(event){
			this.doNoteDelete(event,Event.element(event).up().up().id.split('_')[1] );
		}.bindAsEventListener(this));	
		
		prototypenotes.select(this.completenote).invoke('observe','click',function(event){
			this.doNoteComplete(event,Event.element(event).up().up().id.split('_')[1] );
		}.bindAsEventListener(this));		
	},
	
	doNoteReply : function( event,noteid ){
		Event.stop(event);
		var notediv = this.getNoteDiv(noteid)
		notediv.down(this.notelinks).remove();
		notediv.insert(this.template.getNoteForm(noteid));
		notediv.down( this.noteform ).observe('submit',function(event){
			this.doNoteForm(event, Event.element(event));
			notediv.down( this.noteform ).up().remove();
		}.bindAsEventListener(this));
		notediv.down( this.noteform ).down(this.cancelnote).observe('click',function(event){
			this.doCancelNoteForm(event,noteid);
		}.bindAsEventListener(this));
			
	},
	
	doCancelNoteForm : function(event,noteid){
		var notediv = this.getNoteDiv(noteid);
		notediv.down(this.noteformcontainer).remove();
		notediv.insert(this.template.getNoteLink(), {position:'top'});
		this.activateNoteLink(noteid);
	},
	
	doNoteForm : function(event,form){
		Event.stop(event);
		$(this.cfprototypemessage).update('');
		if (form.note_text.value.length > 0 ){
			new Ajax.Request( 
				form.readAttribute( 'action' ) + '&uid=' + new Date().getTime(),
				{
					method : 'get',
					parameters : form.serialize(),
					onSuccess : this.afterNoteForm.bindAsEventListener(this)
				}
			);
		}
	},
	
	afterNoteForm : function(transport){
		var json = transport.responseText.evalJSON();
		if (json['VALID'] == true){
			json = json['DATA'];
			var parent = json['PARENT_ID'] == this.rootnoteid ? $(this.prototypenotes).down() : $(this.prototypenotes).down('div#note_' + json['PARENT_ID'] );
			parent.insert(this.template.getNoteTemplate(json));
			this.activateNoteLink(json['ID']);
			$("newnoteform").note_text.value = '';
		}
		else {
			$(this.cfprototypemessage).update(json['MESSAGE']);
		}
	},
	
	doNoteComplete: function(event,noteid ){
		Event.stop(event);
		$(this.cfprototypemessage).update('');
		new Ajax.Request(
				this.xfacomplete,
				{
					method:'get',
					parameters: { note_id: noteid, uid: new Date().getTime() },
					onSuccess:this.afterNoteComplete.bindAsEventListener(this)
				}
			);
	},
	
	afterNoteComplete : function(transport){
		var json = transport.responseText.evalJSON();
		if (json['VALID'] == true ){
			var notediv = this.getNoteDiv(json['DATA']);
			if (notediv.hasClassName("note-parent"))
				notediv.remove();
			else
				notediv.up("div.note-parent").remove();
		}
		else{
			$(this.cfprototypemessage).update(json['MESSAGE']);
		}
	},
	
	doNoteDelete : function( event,noteid ){
		Event.stop(event);
		$(this.cfprototypemessage).update('');
		new Ajax.Request(
				this.xfadelete,
				{
					method:'get',
					parameters: { note_id: noteid, uid: new Date().getTime() },
					onSuccess:this.afterNoteDelete.bindAsEventListener(this)
				}
			);
	},
	
	afterNoteDelete : function(transport){
		var json = transport.responseText.evalJSON();
		if (json['VALID'] == true ){
			var notediv = this.getNoteDiv(json['DATA']);
			var parent = notediv.up("div.note");
			notediv.remove();
			if (parent){
				parent.insert(this.template.getNoteLink());
				this.activateNoteLink(parent.id.split('_')[1]);
			}
		}
		else{
			$(this.cfprototypemessage).update(json['MESSAGE']);
		}
	},
	
	activateNoteLink : function(noteid){
		var notediv = this.getNoteDiv(noteid);
		notediv.select(this.nolink).each( function(item){
			item.writeAttribute("href",'javascript:void(0)');
		});
		notediv.down(this.replynote).observe('click', function(event){
			this.doNoteReply(event,noteid);	
		}.bindAsEventListener(this));
		
		var deletenote = notediv.down(this.deletenote);
		if (deletenote){
			deletenote.observe('click', function(event){
				this.doNoteDelete(event,noteid);	
			}.bindAsEventListener(this));
		}
		
		var completenote = notediv.down(this.completenote);
		if (completenote){
			completenote.observe('click', function(event){
				this.doNoteComplete(event,noteid);	
			}.bindAsEventListener(this));
		}
	},
	
	getNoteDiv : function(noteid){
		return $(this.prototypenotes).down('div#note_' + noteid);
	}
});
