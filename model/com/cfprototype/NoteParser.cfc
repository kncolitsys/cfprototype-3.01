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
<cfcomponent output="false" displayname="NoteParser" hint="">

<cffunction name="init" returntype="NoteParser" output="false" access="public" hint="Constructor">
	<cfargument name="NoteQuery" type="query" required="true" />
	<cfset setNoteQuery( arguments.NoteQuery ) />
	<cfreturn this />
</cffunction>

<!--- PUBLIC METHODS --->
<cffunction name="formatNotes" returntype="xml" access="package" output="false" hint="">
	<cfargument name="isadmin" type="boolean" required="true" hint="" />
	<cfargument name="dolinks" type="boolean" required="true" hint="" />
	<cfset var xml = '' />
	<cfset var xslParams = StructNew() />
	<cfset xslParams[ 'dolinks' ] = arguments.dolinks />
	<cfset xslParams[ 'isadmin' ] = arguments.isadmin />
	<cfsavecontent variable="xml">
	<cfoutput>
	<notes>
		#formatNote()#
	</notes>
	</cfoutput>
	</cfsavecontent>
	<!--- <cffile action="write" file="#getDirectoryFromPath( getCurrentTemplatePath() )#\note.xml" output="#ToString( xml )#" />
	<cfdump var="#xml#">
	<cfabort> --->
 	<cfreturn XMLTransform( xml, getDirectoryFromPath( getCurrentTemplatePath() ) & 'note.xsl', xslParams ) /> 
	
</cffunction>

<!--- PRIVATE METHODS --->
<cffunction name="formatNote" returntype="string" access="private" output="false" hint="">
	<cfargument name="qFilter" type="query" default="#filter( depth = 1 )#" hint="" />
	<cfset var ret = '' />
	<cfsavecontent variable="ret">
	<cfoutput>
	<cfloop query="arguments.qFilter">
		<note id="#XMLFormat( note_id )#" depth="#XMLFormat( depth )#">
			<text>#XMLFormat( note_text )#</text>
			<date>#XMLFormat( DateFormat( note_date,  'mm-dd-yyyy' ) )#</date>
			<author>#XMLFormat( first_name &  ' ' & last_name )#</author>
			#formatNote( filter( qFilter['depth'][currentrow] + 1, qFilter['note_lft'][currentrow], qFilter['note_rgt'][currentrow]  ) )#
		</note>
	</cfloop>
	</cfoutput>
	</cfsavecontent>
	<cfreturn ret />
</cffunction>

<cffunction name="filter" returntype="query" access="private" output="false" hint="">
	<cfargument name="depth" type="numeric" required="true" hint="" />
	<cfargument name="lft" type="numeric" required="false" hint="" />
	<cfargument name="rgt" type="numeric" required="false" hint="" />
	<cfset var qfilter =  "" />
	<cfset var q = getNoteQuery() />
	<cfquery name="qfilter" dbtype="query">
		SELECT	*
		FROM	q
		WHERE	depth = #arguments.depth#
				<cfif StructKeyExists( arguments, 'lft' )>
					AND note_lft BETWEEN #arguments.lft# AND #arguments.rgt#
				</cfif>
	</cfquery>
	<cfreturn qfilter />
</cffunction>


<!--- GETTER & SETTER --->
<cffunction name="getNoteQuery" access="public" returntype="query" output="false" hint="Getter for NoteQuery">
	<cfreturn variables.instance.NoteQuery />
</cffunction>

<cffunction name="setNoteQuery" access="public" returntype="void" output="false" hint="Setter for NoteQuery">
	<cfargument name="NoteQuery" type="query" required="true" />
	<cfset variables.instance.NoteQuery = arguments.NoteQuery>
</cffunction>

</cfcomponent>