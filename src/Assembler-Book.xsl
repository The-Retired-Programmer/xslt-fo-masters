<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : Assembler-Book.xsl
    Author     : richard
    Description:
        Templates for assembling a book
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <xsl:import href="Assembler-CoreTemplates.xsl"/>
    
    <xsl:template match="titlepage">
        <fo:page-sequence master-reference="bookpart">
            <xsl:call-template name="allempty-footer"/>
            <fo:flow flow-name="body">
                <fo:block xsl:use-attribute-sets="titlefont">
                    <fo:block space-after='2in'>
                        <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
                    </fo:block>
                    <fo:block space-after='1.5in' text-align='center'>
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
                    <fo:block font-size='36pt' text-align='center'  xsl:use-attribute-sets="titlefont">
                        <xsl:value-of select='title'/>
                    </fo:block>
                    <fo:block font-size='36pt' space-before='1.5in' text-align='center'  xsl:use-attribute-sets="titlefont">
                        <xsl:value-of select='title1'/>
                    </fo:block>
                    <fo:block font-size='36pt' space-before='1.0in' text-align='center'  xsl:use-attribute-sets="titlefont">
                        <xsl:value-of select='title2'/>
                    </fo:block>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
    <xsl:template match="publicationdetails">
        <fo:page-sequence master-reference="bookpart">
            <xsl:call-template name="allempty-footer"/>
            <fo:flow flow-name="body" >
                <fo:block break-before='page' xsl:use-attribute-sets='parafont'
                          text-align='end'
                          space-before='60mm'>
        &#x00A9; 
                    <xsl:value-of select="name"/>
                </fo:block>
                <fo:block  xsl:use-attribute-sets='parafont'
                           text-align='end'>
                    <xsl:value-of select="address"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
    <xsl:template match="dedication">
        <fo:page-sequence master-reference="bookpart">
            <xsl:call-template name="allempty-footer"/>
            <fo:flow flow-name="body">
                <fo:block break-before='page' xsl:use-attribute-sets="parafont">
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
    <xsl:template match="preface">
        <fo:page-sequence master-reference="bookpart" force-page-count="end-on-even">
            <xsl:call-template name="pagenumbered-footer"/>
            <fo:flow flow-name="body">
                <fo:block id='{@id}' break-before='page' xsl:use-attribute-sets="parafont">
                    <xsl:call-template name="title">
                        <xsl:with-param name="title" select="@title"/>
                        <xsl:with-param name="toptitle"/>
                    </xsl:call-template>
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
    <xsl:template match="glossary">
        <fo:page-sequence master-reference="bookpart" >
            <xsl:call-template name="pagenumbered-footer"/>
            <fo:flow flow-name="body">
                <fo:block break-before="page" id='{@id}' xsl:use-attribute-sets="parafont">
                    <xsl:call-template name="title">
                        <xsl:with-param name="title" select="@title"/>
                        <xsl:with-param name="toptitle"/>
                    </xsl:call-template>
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
    <xsl:template match="index">
        <fo:page-sequence master-reference="bookpart" >
            <xsl:call-template name="pagenumbered-footer"/>
            <fo:flow flow-name="body">
                <fo:block break-before="page" id='{@id}' xsl:use-attribute-sets="parafont">
                    <xsl:call-template name="title">
                        <xsl:with-param name="title" select="@title"/>
                        <xsl:with-param name="toptitle"/>
                    </xsl:call-template>
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
                <fo:block id="end" />
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
</xsl:stylesheet>
