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
var PageEvent = Class.create({
	initialize : function(xfaDelete){
		this.xfadelete = xfaDelete;
		this.table = 'pagestable';
		this.deletepage = 'a.delete-page';
		this.nolink = 'a.nolink';
		var table = $(this.table);
		
		$(this.table).select(this.nolink).each( function(item){
			item.writeAttribute("href",'javascript:void(0)');
		});
		
		$(this.table).select(this.deletepage).invoke( 'observe', 'click', function(event){
			this.deletePage(event, Event.element(event).up('tr'));
		}.bindAsEventListener(this));
	},
	
	deletePage : function(event,row){
		Event.stop(event);
		var con = confirm("This will delete this page and all  its notes. Are you sure?");
		if (con){
			var pageid = row.id.split('_')[1];
			new Ajax.Request( 
				this.xfadelete,
				{
					method: 'get',
					parameters : { page_id: pageid, uid : new Date().getTime() },
					onSuccess:this.afterDelete.bindAsEventListener(this)
				}
			);
		}
	},
	
	afterDelete: function(transport){
		var json = transport.responseText.evalJSON();
		if (json[ 'VALID' ] == true ) {
			this.getPageRow(json['DATA']).remove();	
		}
	},
	
	getPageRow : function(pageid){
		return $(this.table).down("tr#page_" + pageid);
	}
	
});
