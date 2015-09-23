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
var AjaxHelper = Class.create({ 
	initialize: function(){
		var self = this;
	},
	createLoading: function(){
		document.body.appendChild(new Element( 'div', { id: "ajax-disabled" }).insert( 
																						new Element( 'div', {id: 'ajax-message' } ).update( 'Retrieving data..') )
																					);
	},
	showLoading: function(){
		$('ajax-disabled').show();
	},
	hideLoading: function(){
		$('ajax-disabled').hide();
	}
});
ajaxHelper = new AjaxHelper();

var myGlobalHandlers = {
	onCreate: function(){
		ajaxHelper.showLoading();		
	},
	onComplete: function() {
		if(Ajax.activeRequestCount == 0){
			ajaxHelper.hideLoading();
		}
	}
};

document.observe("dom:loaded", function(){
	ajaxHelper.createLoading();
	ajaxHelper.hideLoading();			
});
// these are handlers that will occur on start and completion of each Ajax request.
Ajax.Responders.register(myGlobalHandlers);