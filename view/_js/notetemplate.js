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
var NoteTemplate = Class.create( {
	initialize : function(rootnoteid,xfainsert,isadmin){
		this.rootnoteid = rootnoteid;
		this.xfainsert = xfainsert;
		this.isadmin = isadmin;
		this.template = {
							note : new Template('<div id="note_#{noteid}" class="note #{noteclass}">#{notedate}:  #{notetext} - #{note_author}<div class="note-links"><a class="nolink reply-note">Reply</a><div class="noteform-container"></div</div></div>'),
							noteadmin : new Template('<div id="note_#{noteid}" class="note #{noteclass}">#{notedate}:  #{notetext} - #{note_author}<div class="note-links"><a class="nolink reply-note">Reply</a> | <a class="nolink delete-note">Delete</a> | <a class="nolink complete-note">Complete</a><div class="noteform-container"></div</div></div>'),
							link : new Template( '<div class="note-links"><a class="nolink reply-note">Reply</a></div>' ),
							linkadmin : new Template( '<div class="note-links"><a class="nolink reply-note">Reply</a> | <a class="nolink delete-note">Delete</a> | <a class="nolink complete-note">Complete</a></div>' ),
							form : new Template('<div class="noteform-container"><form class="cfprototype-noteform" name="noteform" method="post" action="' + xfainsert + '"><textarea cols="40" rows="10" name="note_text" wrap="soft"></textarea><br /><input type="hidden" name="parent_id" value="#{parentid}" /><input type="submit" value="Reply"><input type="button" value="Cancel" class="cancel-note"></form></div>')
						};		
	},
	
	getNoteTemplate : function(json){
		var template = this.isadmin == 'true' ? 'noteadmin' : 'note';
		return this.template[template].evaluate( {
													noteid : json['ID'],
													noteclass : json['PARENT_ID'] == this.rootnoteid ? 'note-parent' : 'note-child', 
													notedate : json['NOTE_DATE'],
													notetext: json['NOTE_TEXT'],
													note_author : json['FIRST_NAME'] + ' ' + json['LAST_NAME']
								});											
	},
	
	getNoteForm : function(noteid){
		return this.template['form'].evaluate( {
												parentid : noteid
												});
	},
	
	getNoteLink : function(){
		var template = this.isadmin == 'true' ? 'linkadmin' : 'link';
		return this.template[template].evaluate( { } );
	}
});
