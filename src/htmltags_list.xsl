<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : htmltags_list.xsl
    Author     : richard
    Description:
        templates to process ordered and unordered lists html tags (to FO)
        
        This stylesheet was derived from 
    a stylesheet written by Doug Tidwell,
    dtidwell@us.ibm.com (ibm.com/developerWorks)
    
    Extracted and updated by Richard Linsdale
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <xsl:variable name="LIST-BULLET-CHAR">&#8226;</xsl:variable>
    <xsl:variable name="LIST-INDENT-CM">0.5</xsl:variable>
    <xsl:variable name="OUTLINE-OUTPUT-START-POS">0</xsl:variable>
    
    <!-- ============================================
    We handle an ordered list with two complications:
    If the list appears inside another list (either 
    an <ol> or <ul>), we don't put any vertical space
    after it.  The other issue is that we indent the
    list according to how deeply nested the list is. 
    =============================================== -->

    <xsl:template match="ol">
        <xsl:variable name="list-indent-with-cm" select="concat($LIST-INDENT-CM, 'cm')"/>
        <fo:list-block provisional-distance-between-starts="{$list-indent-with-cm}"
                       provisional-label-separation="{$list-indent-with-cm}">
            <xsl:attribute name="space-after">
                <xsl:value-of select="$PARA-FONT-SIZE"/>
            </xsl:attribute>
            <xsl:attribute name="start-indent">
                <xsl:variable name="initoffset">
                    <xsl:choose>
                        <xsl:when test="count(ancestor::div[@class='outline-output'])">
                            <xsl:value-of select="$OUTLINE-OUTPUT-START-POS" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>0</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="ancestors">
                    <xsl:choose>
                        <xsl:when test="count(ancestor::ol) or count(ancestor::ul)">
                            <xsl:value-of select="$initoffset + 
                                    (count(ancestor::ol) + 
                                     count(ancestor::ul)) * 
                                    $LIST-INDENT-CM"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$initoffset" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="concat($ancestors, 'cm')"/>
            </xsl:attribute>
            <xsl:apply-templates select="*"/>
        </fo:list-block>
    </xsl:template>

    <!-- ============================================
    When we handle items in an ordered list, we need
    to check if the list has a start attribute.  If
    it does, we change the starting number accordingly.
    Once we've figured out where to start counting,
    we check the type attribute to see what format
    the numbers should use.  
    =============================================== -->

    <xsl:template match="ol/li">
        <fo:list-item>
            <xsl:attribute name="space-after">
                <xsl:value-of select="$PARA-FONT-SIZE"/>
            </xsl:attribute>
            <fo:list-item-label end-indent="label-end()">
                <fo:block xsl:use-attribute-sets="parafont">
                    <xsl:attribute name="space-after">
                        <xsl:value-of select="$PARA-FONT-SIZE"/>
                    </xsl:attribute>
                    <xsl:variable name="value-attr">
                        <xsl:choose>
                            <xsl:when test="../@start">
                                <xsl:number value="position() + ../@start - 1"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:number value="position()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="../@type='i'">
                            <xsl:number value="$value-attr" format="i. "/>
                        </xsl:when>
                        <xsl:when test="../@type='I'">
                            <xsl:number value="$value-attr" format="I. "/>
                        </xsl:when>
                        <xsl:when test="../@type='a'">
                            <xsl:number value="$value-attr" format="a. "/>
                        </xsl:when>
                        <xsl:when test="../@type='A'">
                            <xsl:number value="$value-attr" format="A. "/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:number value="$value-attr" format="1. "/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block xsl:use-attribute-sets="parafont">
                    <xsl:attribute name="space-after">
                        <xsl:value-of select="$PARA-FONT-SIZE"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <!-- ============================================
    The unordered list is pretty straightforward; 
    the only complication is calculating the space-
    after and start-indent properties.  If this 
    list is inside another list, we don't put any 
    space after this one, and we calculate the 
    indentation based on the nesting level of this 
    list. 
    =============================================== -->

    <xsl:template match="ul">
        <xsl:variable name="list-indent-with-cm" select="concat($LIST-INDENT-CM, 'cm')"/>
        <fo:list-block provisional-distance-between-starts="{$list-indent-with-cm}"
                       provisional-label-separation="{$list-indent-with-cm}">
            <xsl:attribute name="start-indent">
                <xsl:variable name="initoffset">
                    <xsl:choose>
                        <xsl:when test="count(ancestor::div[@class='outline-output'])">
                            <xsl:value-of select="$OUTLINE-OUTPUT-START-POS" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>0</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="ancestors">
                    <xsl:choose>
                        <xsl:when test="count(ancestor::ol) or count(ancestor::ul)">
                            <xsl:value-of select="$initoffset + 
                                    (count(ancestor::ol) + 
                                     count(ancestor::ul)) * 
                                    $LIST-INDENT-CM"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$initoffset" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="concat($ancestors, 'cm')"/>
            </xsl:attribute>
            <xsl:apply-templates select="*"/>
        </fo:list-block>
    </xsl:template>

    <!-- ============================================
    List items inside unordered lists are easy; we
    just have to use the correct Unicode character
    for the bullet.  
    =============================================== -->
    <xsl:template match="ul/li">
        <xsl:variable name="space-after">
            <xsl:choose>
                <xsl:when test="@class = 'examplepara'">
                    <xsl:text>8pt</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0pt</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:list-item>
            <xsl:attribute name="space-after">
                <xsl:value-of select="$PARA-FONT-SIZE"/>
            </xsl:attribute>
            <fo:list-item-label end-indent="label-end()">
                <fo:block xsl:use-attribute-sets="parafont">
                    <xsl:attribute name="space-after">
                        <xsl:value-of select="$PARA-FONT-SIZE"/>
                    </xsl:attribute>
                    <xsl:value-of select="$LIST-BULLET-CHAR" />
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block xsl:use-attribute-sets="parafont">
                    <xsl:attribute name="space-after">
                        <xsl:value-of select="$PARA-FONT-SIZE"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="*|text()"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

</xsl:stylesheet>
