<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : allhtmltags.xsl
    Author     : richard
    Description:
        a simple set of import statements to insert all standard html tag templates
        
        Uses standard components from the various templates involved.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <xsl:import href="htmltags_decorators.xsl"/>
    <xsl:import href="htmltags_tags.xsl"/>
    <xsl:import href="htmltags_headings.xsl"/>
    <xsl:import href="htmltags_table.xsl"/>
    <xsl:import href="htmltags_list.xsl"/>
    
</xsl:stylesheet>
