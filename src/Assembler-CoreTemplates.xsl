<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : Assembler-CoreTemplatesk.xsl
    Author     : richard
    Description:
        Core Templates for use in reports and books
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    <!-- Title at top of every section (chapter,appendix, toc etc etc) -->
    <xsl:template name="title" >
        <xsl:param name="title"/>
        <xsl:param name="toptitle"/>
        <fo:marker marker-class-name="title">
            <xsl:value-of select="$title"/>
        </fo:marker>
        <fo:block  text-align='outside' space-after='1.5in' line-height="100%" xsl:use-attribute-sets="titlefont">
            <fo:block font-size='16pt' space-after="0in">
                <xsl:value-of select="$toptitle" />
            </fo:block>
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block font-size='24pt' space-after="0in" space-before="8pt" >
                <xsl:value-of select='$title'/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="toc">
        <fo:page-sequence master-reference="bookpart" initial-page-number="1" format="i" force-page-count="end-on-even">
            <xsl:call-template name="pagenumbered-footer"/>
            <fo:flow flow-name="body">
                <fo:block break-before='page' >
                    <xsl:call-template name="title">
                        <xsl:with-param name="title" select="@title"/>
                        <xsl:with-param name="toptitle"/>
                    </xsl:call-template>
                    <xsl:for-each select='/publication/preface'>
                        <fo:block text-align-last="justify" line-height="200%">
                            <fo:inline>
                                <xsl:value-of select="@title"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{@id}"/>
                            </fo:inline>
                        </fo:block>
                    </xsl:for-each>
                    <xsl:for-each select='/publication/chapters/chapter'>
                        <fo:block text-align-last="justify" line-height="200%">
                            <fo:inline>
                                Chapter <xsl:number value="position()" format="1"/>. 
                                <xsl:value-of select="@title"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{@id}"/>
                            </fo:inline>
                        </fo:block>
                    </xsl:for-each>
                    <xsl:for-each select='/publication/appendices/appendix'>
                        <fo:block text-align-last="justify" line-height="200%">
                            <fo:inline>
                                Appendix <xsl:number value="position()" format="A"/>.
                                <xsl:value-of select="@title"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{@id}"/>
                            </fo:inline>
                        </fo:block>
                    </xsl:for-each>
                    <xsl:for-each select='/publication/glossary'>
                        <fo:block text-align-last="justify" line-height="200%">
                            <fo:inline>
                                <xsl:value-of select="@title"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{@id}"/>
                            </fo:inline>
                        </fo:block>
                    </xsl:for-each>
                    <xsl:for-each select='/publication/index'>
                        <fo:block text-align-last="justify" line-height="200%">
                            <fo:inline>
                                <xsl:value-of select="@title"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{@id}"/>
                            </fo:inline>
                        </fo:block>
                    </xsl:for-each>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
    <xsl:template match="chapters/chapter">
        <fo:page-sequence master-reference="bookpart" force-page-count="end-on-even" >
            <xsl:if test="position() = 1">
                <xsl:attribute name="initial-page-number">1</xsl:attribute>
                <xsl:attribute name="format">1</xsl:attribute>
            </xsl:if>
            <xsl:call-template name="pagenumbered-footer"/>
            <fo:flow flow-name="body">
                <fo:block break-before='page' id='{@id}'>
                    <xsl:variable name="cno">
                        <xsl:number count="chapter" level="any" from="chapters" />
                    </xsl:variable>
                    <xsl:variable name="cno-f">
                        <xsl:number value="$cno" format="1"/>
                    </xsl:variable>
                    <fo:marker marker-class-name="chapNum" >
                        <xsl:value-of select="$cno"/>
                    </fo:marker>
                    <xsl:call-template name="title">
                        <xsl:with-param name="title" select="@title"/>
                        <xsl:with-param name="toptitle" select="concat('Chapter ',$cno-f)"/>
                    </xsl:call-template>
                </fo:block>
                <fo:block xsl:useattribute-sets="parafont">
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
    <xsl:template match="appendices/appendix">
        <fo:page-sequence master-reference="bookpart" >
            <xsl:call-template name="pagenumbered-footer"/>
            <fo:flow flow-name="body">
                <fo:block break-before='page' id='{@id}'>
                    <xsl:variable name="ano">
                        <xsl:number count="appendix" level="any" from="appendices" />
                    </xsl:variable>
                    <xsl:variable name="ano-f">
                        <xsl:number value="$ano" format="A"/>
                    </xsl:variable>
                    <fo:marker marker-class-name="appNum">
                        <xsl:value-of select="$ano"/>
                    </fo:marker>
                    <xsl:call-template name="title">
                        <xsl:with-param name="title" select="@title"/>
                        <xsl:with-param name="toptitle" select="concat('Appendix ',$ano-f)"/>
                    </xsl:call-template>
                </fo:block>
                <fo:block xsl:useattrubute-sets="parafont">
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
            
</xsl:stylesheet>
