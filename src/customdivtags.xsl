<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : htmltags_customdiv.xsl
    Author     : richard
    Description:
        templates to process custom div tags (to FO)
        
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <!-- handle the outline-input and outline-output special tag -->

    <xsl:template match="div[@class='outline-input']">
        <fo:block background-color="lightgrey"
                  start-indent="0.5cm" end-indent="0.5cm"
                  padding="0.2cm" space-after="8pt"
                  border-after-style="solid"
                  border-after-color="black" border-after-width="1px"
                  keep-together.within-column="always">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="div[@class='outline-input-connected']">
        <fo:block background-color="lightgrey"
                  start-indent="0.5cm" end-indent="0.5cm"
                  padding="0.2cm" space-after="0"
                  border-after-style="solid"
                  border-after-color="black" border-after-width="1px"
                  keep-with-next.within-column="always"
                  keep-together.within-column="always">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
        <fo:block  space-after="0"  text-align="center"
                   keep-with-next.within-column="always">
            <fo:inline xsl:use-attribute-sets="parafont" line-height="1">
                |||
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="div[@class='outline-output']">
        <fo:block background-color="lightgrey"
                  start-indent="0.5cm" end-indent="0.5cm"
                  padding="0.2cm" space-after="8pt"
                  border-before-style="solid"
                  border-before-color="black" border-before-width="1px"
                  keep-together.within-column="always">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>
    
    <!-- set to start indent + padding -->
    <xsl:variable name="OUTLINE-OUTPUT-START-POS">0.7</xsl:variable>

</xsl:stylesheet>
