<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : htmltags_table.xsl
    Author     : richard
    Description:
        templates to process html table tags (to FO)
        
        This stylesheet was derived from 
    a stylesheet written by Doug Tidwell,
    dtidwell@us.ibm.com (ibm.com/developerWorks)
    
    Extracted and updated by Richard Linsdale
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    

    <!-- ============================================
    Tables are a hassle.  The main problem we have
    is converting the cols attribute into some 
    number of <fo:table-column> elements.  We do 
    this with a named template called build-columns.
    Once we've processed the cols attribute, we 
    invoke all of the templates for the children 
    of this element. 
    =============================================== -->

    <xsl:template match="table">
        <fo:table table-layout="fixed" inline-progression-dimension="100%">
            <xsl:if test="@background-color">
                <xsl:attribute name="background-color">
                    <xsl:value-of select="@background-color" />
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@layout" >
                <xsl:call-template name="build-columns">
                    <xsl:with-param name="layout" select="@layout"/>
                    <xsl:with-param name="colnum">1</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            <fo:table-body>
                <xsl:apply-templates select="*"/>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    
    <!-- ============================================
    This template generates an <fo:table-column>
    element for each token in the layout attribute of
    the HTML <table> tag.  The template processes
    the first token, then invokes itself with the 
    rest of the string. 
    =============================================== -->

    <xsl:template name="build-columns">
        <xsl:param name="layout"/>
        <xsl:param name="colnum"/>
        <xsl:variable name="trimmedlayout">
            <xsl:value-of select="normalize-space($layout)"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains($trimmedlayout,',')">
                <fo:table-column column-number="{$colnum}" column-width="{substring-before($trimmedlayout,',')}"/>
                <xsl:call-template name="build-columns">
                    <xsl:with-param name="layout" select="substring-after($trimmedlayout,',')"/>
                    <xsl:with-param name="colnum" select="$colnum + 1" />
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$trimmedlayout">
                <fo:table-column column-number="{$colnum}" column-width="{$trimmedlayout}"/>
            </xsl:when>
        </xsl:choose>    
    </xsl:template>

    <!-- ============================================
    For a table cell, we put everything inside a
    <fo:table-cell> element.  We set the padding
    property correctly, then we set the border 
    style.  For the border style, we look to see if
    any of the ancestor elements we care about 
    specified a solid border.  Next, we check for the 
    =============================================== -->

    <xsl:template name="tdth">
        <xsl:param name="font-weight"/>
        <xsl:param name="include-topborder"/>
        <xsl:param name="cell-pos" />
        <fo:table-cell 
            padding-start="3pt" padding-end="3pt"
            padding-before="3pt" padding-after="3pt">
            <xsl:if test="@colspan">
                <xsl:attribute name="number-columns-spanned">
                    <xsl:value-of select="@colspan"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rowspan">
                <xsl:attribute name="number-rows-spanned">
                    <xsl:value-of select="@rowspan"/>
                </xsl:attribute>
            </xsl:if>
            <!-- borderstyle processing -->
            <xsl:if test="ancestor::table/@borders = 'full' ">
                <xsl:attribute name="border-style">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-style]">
                            <xsl:value-of select="ancestor::table/@border-style"/>
                        </xsl:when>
                        <xsl:otherwise>solid</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="border-color">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-color]">
                            <xsl:value-of select="ancestor::table/@border-color"/>
                        </xsl:when>
                        <xsl:otherwise>black</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="border-width">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-width]">
                            <xsl:value-of select="ancestor::table/@border-width"/>
                        </xsl:when>
                        <xsl:otherwise>1pt</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="ancestor::table/@borders = 'internal' and $include-topborder = 'true' ">
                <xsl:attribute name="border-top-style">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-style]">
                            <xsl:value-of select="ancestor::table/@border-style"/>
                        </xsl:when>
                        <xsl:otherwise>solid</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="border-top-color">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-color]">
                            <xsl:value-of select="ancestor::table/@border-color"/>
                        </xsl:when>
                        <xsl:otherwise>black</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="border-top-width">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-width]">
                            <xsl:value-of select="ancestor::table/@border-width"/>
                        </xsl:when>
                        <xsl:otherwise>1pt</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="ancestor::table/@borders = 'internal' and not($cell-pos = 1) ">
                <xsl:attribute name="border-start-style">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-style]">
                            <xsl:value-of select="ancestor::table/@border-style"/>
                        </xsl:when>
                        <xsl:otherwise>solid</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="border-start-color">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-color]">
                            <xsl:value-of select="ancestor::table/@border-color"/>
                        </xsl:when>
                        <xsl:otherwise>black</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="border-start-width">
                    <xsl:choose>
                        <xsl:when test="ancestor::table[@border-width]">
                            <xsl:value-of select="ancestor::table/@border-width"/>
                        </xsl:when>
                        <xsl:otherwise>1pt</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:variable name="align">
                <xsl:choose>
                    <xsl:when test="@style='text-align: left'">
                        <xsl:text>start</xsl:text>
                    </xsl:when>
                    <xsl:when test="@style='text-align: right'">
                        <xsl:text>end</xsl:text>
                    </xsl:when>
                    <xsl:when test="@style='text-align: center'">
                        <xsl:text>center</xsl:text>
                    </xsl:when>
                    <xsl:when test="@style='text-align: justify'">
                        <xsl:text>justify</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>start</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>           
            </xsl:variable>
            <fo:block text-align="{$align}" xsl:use-attribute-sets="parafont" font-weight="{$font-weight}">
                <xsl:apply-templates select="*|text()"/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <!-- ============================================
    The rarely-used <tfoot> element contains some
    number of <tr> elements; we just invoke the 
    template for <tr> here. 
    =============================================== -->

    <xsl:template match="tfoot">
        <xsl:for-each select="tr">
            <fo:table-row>
                <xsl:for-each select="td">
                    <xsl:call-template name="tdth">
                        <xsl:with-param name="font-weight">normal</xsl:with-param>
                        <xsl:with-param name="include-topborder">true</xsl:with-param>
                        <xsl:with-param name="cell-pos">
                            <xsl:value-of select="position()" />
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </fo:table-row>
        </xsl:for-each>
    </xsl:template>

    <!-- ============================================
    Just like <tfoot>, the rarely-used <thead> element
    contains some number of table rows.  We just 
    invoke the template for <tr> here. 
    =============================================== -->

    <xsl:template match="thead">
        <xsl:for-each select="tr">
            <fo:table-row>
                <xsl:for-each select="th">
                    <xsl:call-template name="tdth">
                        <xsl:with-param name="font-weight">bold</xsl:with-param>
                        <xsl:with-param name="include-topborder">false</xsl:with-param>
                        <xsl:with-param name="cell-pos">
                            <xsl:value-of select="position()" />
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </fo:table-row>
        </xsl:for-each>
    </xsl:template>

    <!-- ============================================
    For an HTML table row, we create an XSL-FO table
    row, then invoke the templates for everything 
    inside it. 
    =============================================== -->

    <xsl:template match="tr">
        <fo:table-row>
            <xsl:for-each select="td">
                <xsl:call-template name="tdth">
                    <xsl:with-param name="font-weight">normal</xsl:with-param>
                    <xsl:with-param name="include-topborder">true</xsl:with-param>
                    <xsl:with-param name="cell-pos">
                        <xsl:value-of select="position()" />
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
        </fo:table-row>
    </xsl:template>

</xsl:stylesheet>
