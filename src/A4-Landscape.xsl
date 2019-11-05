<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : A4-landscape.xsl
    Author     : richard
    Description:
        A4 Landscape document definitions and FO creation to flow level
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

    <!--  ==============================================================
       Sets of attributes for page layout definitions
    =============================================================== -->
    
    <xsl:variable name="COLUMN-COUNT">1</xsl:variable>
    <xsl:variable name="STD-MARGIN">0.2</xsl:variable>
    <xsl:variable name="STD-MARGIN-UNIT">in</xsl:variable>

    <xsl:attribute-set name="page">
        <xsl:attribute name="page-height">21.0cm</xsl:attribute>
        <xsl:attribute name="page-width">29.7cm</xsl:attribute>
        <xsl:attribute name="margin-top">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>   
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>    
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>    
        </xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="column">
        <xsl:attribute name="column-count">
            <xsl:value-of select="$COLUMN-COUNT"/>
        </xsl:attribute>
        <xsl:attribute name="column-gap">
            <xsl:value-of select="concat($STD-MARGIN*2,$STD-MARGIN-UNIT)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    
    <!--  ==============================================================
       Top level template - matches the root element of the source
    =============================================================== -->
    
    <xsl:template match="/publication">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" >
            <fo:layout-master-set>
                <fo:simple-page-master master-name="pagemaster" xsl:use-attribute-sets="page">
                    <fo:region-body region-name="pageregion" xsl:use-attribute-sets="column"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <xsl:apply-templates select="*"/>
        </fo:root>
    </xsl:template>
    
</xsl:stylesheet>
