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
<cfcomponent output="false" displayname="NoteDAO" hint="" extends="AbstractDAO">

<cffunction name="init" returntype="NoteDAO" output="false" access="public" hint="Constructor">
	<cfreturn super.init( argumentCollection = arguments ) />
</cffunction>

<!--- PACKAGE METHODS --->
<cffunction name="getNotesForPage" returntype="query" access="package" output="false" hint="">
	<cfargument name="page_id" type="string" required="true" hint="" />
	<cfargument name="is_completed" type="string" required="false" hint="" />
	<cfset var qNotesForPage = '' />
	
	<cfquery name="qNotesForPage" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT  node.id AS note_id
        		, node.note_text
        		, (COUNT(parent.id) - 1) AS depth
				, node.note_lft
				, node.note_rgt
				, node.note_date
				, u.first_name
				, u.last_name
		FROM    cfp_note node,
        		cfp_note parent
				, cfp_user u
		WHERE   node.note_lft BETWEEN parent.note_lft AND parent.note_rgt
				AND u.id = node.user_id
				AND u.prototype_id = node.prototype_id
				AND node.prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND node.page_id = parent.page_id
				AND node.prototype_id = parent.prototype_id 
				AND node.page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				<cfif StructKeyExists( arguments, 'is_completed' ) AND Len( Trim( arguments.is_completed ) )>
					AND node.is_completed = <cfqueryparam value="#arguments.is_completed#" cfsqltype="cf_sql_char" />
				</cfif>
		GROUP BY node.id, node.note_text,node.note_lft, node.note_rgt,node.note_date,u.first_name, u.last_name
		Having ((COUNT(parent.id) - 1) > 0)
		ORDER BY node.note_lft			
	</cfquery>
	<cfreturn qNotesForPage />
</cffunction>

<cffunction name="getNotesForPrototype" returntype="query" access="package" output="false" hint="">
	<cfset var qNotesForPrototype = '' />
	<cfquery name="qNotesForPrototype" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT  node.id AS note_id
				, ( SELECT page_name FROM cfp_page WHERE id = node.page_id) AS page_name
        		, node.note_text
				, node.note_date
				, u.first_name
				, u.last_name
		FROM    cfp_note node,
        		cfp_note parent
				, cfp_user u
		WHERE   node.note_lft BETWEEN parent.note_lft AND parent.note_rgt
				AND u.id = node.user_id
				AND u.prototype_id = node.prototype_id
				AND node.prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND node.page_id = parent.page_id
				AND node.prototype_id = parent.prototype_id 
		GROUP BY node.id, node.note_text,node.note_lft, node.note_rgt,node.note_date,u.first_name, u.last_name, node.page_id
		Having ((COUNT(parent.id) - 1) > 0)
		ORDER BY node.page_id, node.note_lft			
	</cfquery>
	<cfreturn qNotesForPrototype />
</cffunction>

<cffunction name="read" returntype="query" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="note_text" type="string" required="false" hint="" />
	<cfargument name="note_id" type="numeric" required="false" hint="" />
	<cfset var qRead = '' />
	<cfquery name="qRead" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT	note.*
				, u.first_name
				, u.last_name
				, p.page_name
		FROM	cfp_note note
					LEFT OUTER JOIN cfp_user u
						ON u.id= note.user_id
						AND u.prototype_id = note.prototype_id
						INNER JOIN cfp_page p
							ON p.id = note.page_id
							AND p.prototype_id = note.prototype_id
		WHERE	note.prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND note.page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				<cfif StructKeyExists( arguments, 'note_text' )>
					AND note.note_text = <cfqueryparam value="#arguments.note_text#" cfsqltype="cf_sql_varchar" />
				</cfif>
				<cfif StructKeyExists( arguments, 'note_id' )>
					AND note.id = <cfqueryparam value="#arguments.note_id#" cfsqltype="cf_sql_integer" />
				</cfif>
	</cfquery>
	<cfreturn qRead />
</cffunction>

<cffunction name="createRoot" returntype="void" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="user_id" type="numeric" required="true" hint="" />
	<cfset var nextId = ''/>
	<cftransaction>
		<cfset nextId = getNextID( 'cfp_note' ) />
		<cfset create( note_id = nextId, page_id = arguments.page_id, user_id = arguments.user_id, note_left = 1, note_right = 2, note_text = 'root' ) />
	</cftransaction>
</cffunction>

<cffunction name="insertNote" returntype="query" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="parent_id" type="numeric" required="true" hint="" />
	<cfargument name="user_id" type="numeric" required="true" hint="" />
	<cfargument name="note_text" type="string" required="true" hint="" />
	<cfset var qParent = '' />
	<cfset var nextId = '' />
	<cfset var dsn = getDSN() />
	<cftransaction>
	<cfset nextId = getNextID( 'cfp_note' ) />
	<cfset qParent = read( page_id = arguments.page_id, note_id = arguments.parent_id ) />
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		UPDATE	cfp_note
		SET		note_rgt = note_rgt + 2
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				AND note_rgt >= <cfqueryparam value="#qParent.note_rgt#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		UPDATE	cfp_note
		SET		note_lft = note_lft + 2
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				AND note_lft >= <cfqueryparam value="#qParent.note_rgt#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfset create( 	note_id = nextId, 
					page_id = arguments.page_id, 
					user_id = arguments.user_id, 	
					note_left = qParent.note_rgt,
					note_right = qParent.note_rgt + 1,
					note_text = arguments.note_text ) />
	</cftransaction>
	<cfreturn read( page_id = arguments.page_id, note_id = nextId ) />
</cffunction>

<cffunction name="removeNote" returntype="void" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="note_id" type="numeric" required="true" hint="" />
	<cfset var q = '' />
	<cfset var dsn = getDSN() />
	<cftransaction>
	<cfquery name="q" datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		SELECT	note_lft
				, note_rgt
				, ( note_rgt - note_lft + 1 ) AS width
		FROM	cfp_note
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				AND id = <cfqueryparam value="#arguments.note_id#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		DELETE 
		FROM	cfp_note
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				AND note_lft BETWEEN <cfqueryparam value="#q.note_lft#" cfsqltype="cf_sql_integer" /> AND <cfqueryparam value="#q.note_rgt#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		UPDATE	cfp_note
		SET		note_rgt = note_rgt - <cfqueryparam value="#q.width#" cfsqltype="cf_sql_integer" />
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				AND note_rgt > <cfqueryparam value="#q.note_rgt#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		UPDATE	cfp_note
		SET		note_lft = note_lft - <cfqueryparam value="#q.width#" cfsqltype="cf_sql_integer" />
		WHERE	prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
				AND note_lft >= <cfqueryparam value="#q.note_rgt#" cfsqltype="cf_sql_integer" />
	</cfquery>
	</cftransaction>
</cffunction>

<cffunction name="completeNote" returntype="void" access="package" output="false" hint="">
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="note_id" type="numeric" required="true" hint="" />
	<cfset var dsn = getDSN() />
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		UPDATE  cfp_note
		SET     is_completed = 'Y'
		WHERE   id IN ( <cfqueryparam value="#getParentID( argumentCollection = arguments )#" cfsqltype="cf_sql_integer" list="true" />)
	</cfquery>
</cffunction>

<cffunction name="create" returntype="void" access="public" output="false" hint="">
	<cfargument name="note_id" type="numeric" required="true" hint="" />
	<cfargument name="page_id" type="numeric" required="true" hint="" />
	<cfargument name="user_id" type="numeric" required="true" hint="" />
	<cfargument name="note_left" type="numeric" required="true" hint="" />
	<cfargument name="note_right" type="numeric" required="true" hint="" />
	<cfargument name="note_text" type="string" required="true" hint="" />	
	
	<cfset var dsn = getDSN() />
	<cfquery datasource="#dsn.dsn#" username="#dsn.username#" password="#dsn.password#">
		INSERT INTO cfp_note
		(
			id
			, note_lft
			, note_rgt
			, note_text
			, page_id
			, user_id
			, prototype_id
			, note_date
		)
		VALUES
		(
			<cfqueryparam value="#arguments.note_id#" cfsqltype="cf_sql_integer" />
			, <cfqueryparam value="#arguments.note_left#" cfsqltype="cf_sql_integer" />
			, <cfqueryparam value="#arguments.note_right#" cfsqltype="cf_sql_integer" />
			, <cfqueryparam value="#arguments.note_text#" cfsqltype="cf_sql_varchar" />
			, <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
			, <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer" />
			, <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
			, <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date" />
		)
	</cfquery>
</cffunction>
<!--- PRIVATE METHODS --->

<cffunction name="getParentID" returntype="string" access="private" output="false" hint="">
	<cfset var q = '' />
	<cfquery name="q" datasource="#getDSN().dsn#" username="#getDSN().username#" password="#getDSN().password#">
		SELECT 	parent.id
		FROM    cfp_note node
     			, cfp_note parent
		WHERE   parent.note_lft <= node.note_lft
				AND parent.note_rgt >= node.note_rgt
				AND node.page_id = parent.page_id
   							AND node.prototype_id = parent.prototype_id
   							AND parent.note_text != 'root'
				AND node.prototype_id = <cfqueryparam value="#getPrototypeName()#" cfsqltype="cf_sql_varchar" />
				AND node.page_id = <cfqueryparam value="#arguments.page_id#" cfsqltype="cf_sql_integer" />
     			AND node.id = <cfqueryparam value="#arguments.note_id#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfreturn ValueList( q.id ) />
</cffunction>

<!--- GETTER & SETTER --->
</cfcomponent>