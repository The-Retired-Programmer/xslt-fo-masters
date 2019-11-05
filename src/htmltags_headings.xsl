<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : htmltags_header.xsl
    Author     : richard
    Description:
        templates to process bhtml heading tags (to FO)
        
        This stylesheet was derived from 
    a stylesheet written by Doug Tidwell,
    dtidwell@us.ibm.com (ibm.com/developerWorks)
    
    Extracted and updated by Richard Linsdale
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <xsl:template match="h1">
        <fo:block space-after='0.0in'   keep-with-next.within-column="always">
            <fo:leader leader-pattern="rule" leader-length.maximum="100%"
                       leader-length.optimum="100%"/>
        </fo:block>
        <fo:block xsl:use-attribute-sets="titlefont" font-size="12pt" keep-with-next.within-column="always" >
            <xsl:attribute name="space-after">
                <xsl:value-of select="$NARROW-VSPACE"/>
            </xsl:attribute>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="h2">
        <fo:block xsl:use-attribute-sets="titlefont" font-size="11pt" keep-with-next.within-column="always" >
            <xsl:attribute name="space-before">
                <xsl:value-of select="$WIDE-VSPACE"/>
            </xsl:attribute>
            <xsl:attribute name="space-after">
                <xsl:value-of select="$NARROW-VSPACE"/>
            </xsl:attribute>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="h3">
        <fo:block xsl:use-attribute-sets="titlefont" font-weight="bold" font-size="10pt"  keep-with-next.within-column="always">
            <xsl:attribute name="space-before">
                <xsl:value-of select="$WIDE-VSPACE"/>
            </xsl:attribute>
            <xsl:attribute name="space-after">
                <xsl:value-of select="$NARROW-VSPACE"/>
            </xsl:attribute>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="h4|h5|h6">
        <fo:block xsl:use-attribute-sets="titlefont"  keep-with-next.within-column="always">
            <xsl:attribute name="font-size">10pt</xsl:attribute>
            <xsl:attribute name="space-before">
                <xsl:value-of select="$WIDE-VSPACE"/>
            </xsl:attribute>
            <xsl:attribute name="space-after">
                <xsl:value-of select="$NARROW-VSPACE"/>
            </xsl:attribute>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
