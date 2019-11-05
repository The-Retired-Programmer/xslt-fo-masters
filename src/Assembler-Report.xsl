<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : Assembler-Report.xsl
    Author     : richard
    Description:
        Templates for assembling a report
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <xsl:import href="Assembler-CoreTemplates.xsl"/>
    
    <xsl:template match="titlepage">
        <fo:page-sequence master-reference="bookpart">
            <xsl:call-template name="allempty-footer"/>
            <fo:flow flow-name="body">
                <fo:block xsl:use-attribute-sets="titlefont">
                    <fo:block space-after='1in'>
                        <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
                    </fo:block>
                    <xsl:for-each select="title">
                        <xsl:variable name="tsize">
                            <xsl:choose>
                                <xsl:when test="position() = 1">36pt</xsl:when>
                                <xsl:otherwise>24pt</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <fo:block font-size="{$tsize}"  text-align='center'  xsl:use-attribute-sets="titlefont">
                            <xsl:value-of select='text()'/>
                        </fo:block>
                    </xsl:for-each>
                    <fo:block font-size='18pt' space-before='1.5in' text-align='center'  xsl:use-attribute-sets="titlefont">
                        Version: <xsl:value-of select='version'/>
                    </fo:block>
                    <fo:block font-size='18pt' space-before='2in' text-align='center'  xsl:use-attribute-sets="titlefont">
                        Prepared for: <xsl:value-of select='customer'/>    
                    </fo:block>
                    <fo:block font-size='18pt' space-before='1in' text-align='center'  xsl:use-attribute-sets="titlefont">
                        Prepared by: <xsl:value-of select='author'/>    
                    </fo:block>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
  
    <xsl:template match="versionhistory">
        <fo:page-sequence master-reference="bookpart">
            <xsl:call-template name="allempty-footer"/>
            <fo:flow flow-name="body">
                <fo:block break-before='page' xsl:use-attribute-sets="parafont">
                    <xsl:call-template name="title">
                        <xsl:with-param name="title" select="@title"/>
                        <xsl:with-param name="toptitle"/>
                    </xsl:call-template>
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

</xsl:stylesheet>
