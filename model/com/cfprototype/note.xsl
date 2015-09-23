<?xml version='1.0' encoding='utf-8'?>
<!--
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

-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
	<xsl:output method="html"  indent="no" />
	
	<xsl:param name="isadmin" /> 
	<xsl:param name="dolinks" /> 
	
	<xsl:template match="notes">
		<div>
		<xsl:apply-templates select="note" />
		</div>
	</xsl:template>
	
	<xsl:template match="note">
		<div>
			<xsl:attribute name="id">
				<xsl:value-of select="concat('note_',@id)" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="@depth = 1">
						<xsl:value-of select="'note note-parent'" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'note note-child'" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<xsl:value-of select="date" /> <xsl:value-of select="':   '" />
			<xsl:value-of select="text" /><xsl:value-of select="' - '" /><xsl:value-of select="author" />
			
			<xsl:choose>
				<xsl:when test="note">
					<xsl:apply-templates select="note" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="$dolinks = 'true'">
						<xsl:call-template name="note-links" />
					</xsl:if>
					
				</xsl:otherwise>
			</xsl:choose>			
		</div>
	</xsl:template>
	
	<xsl:template name="note-links">
		<div class="note-links">
			<xsl:call-template name="a">
				<xsl:with-param name="text">
					<xsl:value-of select="'Reply'" />
				</xsl:with-param>
				<xsl:with-param name="class"><xsl:value-of select="concat( 'nolink', ' ', 'reply-note' )" /></xsl:with-param>
			</xsl:call-template>
			<xsl:if test="$isadmin = 'true'">
				|
				<xsl:call-template name="a">
					<xsl:with-param name="text">
						<xsl:value-of select="'Delete'" />
					</xsl:with-param>
					<xsl:with-param name="class"><xsl:value-of select="concat( 'nolink', ' ', 'delete-note' )" /></xsl:with-param>
				</xsl:call-template> 
				|
				<xsl:call-template name="a">
					<xsl:with-param name="text">
						<xsl:value-of select="'Completed'" />
					</xsl:with-param>
					<xsl:with-param name="class"><xsl:value-of select="concat( 'nolink', ' ', 'complete-note' )" /></xsl:with-param>
				</xsl:call-template> 	
			</xsl:if>
		</div>
	</xsl:template>
	
	<xsl:template name="a">
		<xsl:param name="text" />
		<xsl:param name="link" select="''" />
		<xsl:param name="class" select="''" />
		<xsl:element name="a">
			<xsl:if test="string-length($link) &gt; 0">
				<xsl:attribute name="href">
					<xsl:value-of select="$link" />
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string-length($class) &gt; 0">
				<xsl:attribute name="class">
					<xsl:value-of select="$class" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$text" />
		</xsl:element>
	</xsl:template>

	
</xsl:stylesheet>