<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : Assembly-SimpleDocumentTrifold.xsl
    Author     : richard
    Description:
        Assembler for simple document plus trailing titlepage (a trifold design)
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

    <xsl:variable name="COLUMN-COUNT">3</xsl:variable>
    
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
                <xsl:call-template name="trailingtitle" />
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template name="trailingtitle">
        <xsl:for-each select="/publication/title" >
            <xsl:call-template name="add-blank-columns">
                <xsl:with-param name="count">
                    <xsl:choose>
                        <xsl:when test="@addblankcolumns">
                            <xsl:choose>
                                <xsl:when test="@addblankcolumns = '' ">0</xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@addblankcolumns"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                    </xsl:choose>
                </xsl:with-param>
            </xsl:call-template>
            <fo:block xsl:use-attribute-sets="titlefont" break-before="column" >
                <fo:block space-after='0.1in'>
                    <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
                </fo:block>
                <fo:block space-after='0.2in' text-align='center'>
                    <fo:inline>
                        <fo:external-graphic >
                            <xsl:attribute name="src">
                                <xsl:value-of select="concat('images/',logo)" />
                            </xsl:attribute>
                            <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                            <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
                            <xsl:attribute name="scaling">uniform</xsl:attribute>
                        </fo:external-graphic>
                    </fo:inline>
                </fo:block>
                <fo:block font-size='36pt' space-before='1.0in' text-align='center'  xsl:use-attribute-sets="titlefont">
                    <xsl:value-of select='title'/>
                </fo:block>
                <fo:block font-size='18pt' space-before='2.0in' text-align='center'  xsl:use-attribute-sets="titlefont">
                    <xsl:value-of select='title1'/>
                </fo:block>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="title|title1">
        <!-- ignore these matches - these element have been processed in trailingtitle template -->
    </xsl:template>
    
    <xsl:template name="add-blank-columns" >
        <xsl:param name="count"/>
        <xsl:if test="$count > 0" >
            <fo:block break-before="column" />
            <xsl:call-template name="add-blank-columns">
                <xsl:with-param name="count" select="$count - 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
            
</xsl:stylesheet>
