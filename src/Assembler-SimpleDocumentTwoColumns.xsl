<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : Assembly-SimpleDocumentTrifold.xsl
    Author     : richard
    Description:
        Assembler for simple two column document
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

    <xsl:variable name="COLUMN-COUNT">2</xsl:variable>
    
    <!--  ==============================================================
       Sets of attributes for font selection
    =============================================================== -->
    
    <xsl:variable name="PARA-FONT-SIZE">9pt</xsl:variable>
    <xsl:variable name="CODE-FONT-SIZE">7pt</xsl:variable>
    <xsl:variable name="LINE-HEIGHT">141%</xsl:variable>
    <xsl:variable name='WIDE-VSPACE'>16pt</xsl:variable>
    <xsl:variable name='NARROW-VSPACE'>8pt</xsl:variable>
    <xsl:variable name="TITLE-FONT-FAMILY">Helvetica</xsl:variable>
    <xsl:variable name="BODY-FONT-FAMILY">Times</xsl:variable>
    <xsl:variable name="CODE-FONT-FAMILY">monospace</xsl:variable>

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


    <!--  ==============================================================
       templates to match content and assemble pages
    =============================================================== -->
    
    <xsl:template match="content">
        <fo:page-sequence master-reference="pagemaster"  >
            <fo:flow flow-name="pageregion">
                <fo:block xsl:useattribute-sets="parafont">
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
</xsl:stylesheet>
