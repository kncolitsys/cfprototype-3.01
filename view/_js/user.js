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
var User = Class.create({
	initialize:function(list){
		this.hash = new Hash();
		for (var i = 0, len = list['recordcount']; i < len ; ++i){
			var data = list['data'];
			this.hash.set( data['id'][i], { userid:data['id'][i],
											firstname:data['first_name'][i],
											lastname:data['last_name'][i],
											email:data['email'][i],
											username:data['username'][i],
											password:data['password'][i],
											isactive:data['is_active'][i],
											isadmin:data['is_active'][i],
											isnotify:data['is_notify'][i]
										} );
		}
	},
	getUser:function(userid){
		return this.hash.get(userid);	
	},
	addUser:function(json){
		this.hash.set( json['ID'],{	userid : json['ID'],
									firstname : json['FIRST_NAME'],
									lastname : json['LAST_NAME'],
									email : json['EMAIL'],
									username : json['USERNAME'],
									password : json['PASSWORD'],
									isactive : json['IS_ACTIVE'],
									isadmin : json['IS_ADMIN'],
									isnotify : json['IS_NOTIFY']
								} );
	}
});
