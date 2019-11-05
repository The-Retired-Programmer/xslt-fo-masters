<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : TextLayout-A4Book.xsl
    Created on : 3 November 2019, 21:48
    Author     : richard
    Description:
        Text LayoutAttributes.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!--  ==============================================================
       Sets of attributes for font selection
    =============================================================== -->
    
    <xsl:variable name="PARA-FONT-SIZE">10pt</xsl:variable>
    <xsl:variable name="CODE-FONT-SIZE">10pt</xsl:variable>
    <xsl:variable name="LINE-HEIGHT">125%</xsl:variable>
    <xsl:variable name='WIDE-VSPACE'>20pt</xsl:variable>
    <xsl:variable name='NARROW-VSPACE'>10pt</xsl:variable>
    <xsl:variable name="TITLE-FONT-FAMILY">Helvetica</xsl:variable>
    <xsl:variable name="BODY-FONT-FAMILY">Times</xsl:variable>
    <xsl:variable name="CODE-FONT-FAMILY">monospace</xsl:variable>
    <xsl:variable name="FOOTER-FONT-FAMILY">Helvetica</xsl:variable>

    <xsl:attribute-set name="titlefont" >
        <xsl:attribute name="line-height">
            <xsl:value-of select="$LINE-HEIGHT" />
        </xsl:attribute>
        <xsl:attribute name='font-family'>
            <xsl:value-of select="$TITLE-FONT-FAMILY"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="keep-with-next">always</xsl:attribute>
        <xsl:attribute name="page-break-inside">avoid</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="parafont" >
        <xsl:attribute name="font-size">
            <xsl:value-of select="$PARA-FONT-SIZE" />
        </xsl:attribute>
        <xsl:attribute name="line-height">
            <xsl:value-of select="$LINE-HEIGHT" />
        </xsl:attribute>
        <xsl:attribute name='font-family'>
            <xsl:value-of select="$BODY-FONT-FAMILY"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="space-after">
            <xsl:value-of select="$NARROW-VSPACE" />
        </xsl:attribute> 
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codefont" >
        <xsl:attribute name="font-family">
            <xsl:value-of select="$CODE-FONT-FAMILY"/>
        </xsl:attribute>
        <xsl:attribute name="font-size" >
            <xsl:value-of select="$PARA-FONT-SIZE" />
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="line-height">
            <xsl:value-of select="$LINE-HEIGHT" />
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="footerfont">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$PARA-FONT-SIZE" />
        </xsl:attribute>
        <xsl:attribute name='font-family'>
            <xsl:value-of select="$FOOTER-FONT-FAMILY" />
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
</xsl:stylesheet>
