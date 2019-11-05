<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : htmltags_tags.xsl
    Author     : richard
    Description:
        templates to process html tags which render (to FO)
        
        This stylesheet was derived from 
    a stylesheet written by Doug Tidwell,
    dtidwell@us.ibm.com (ibm.com/developerWorks)
    
    Extracted and updated by Richard Linsdale
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <!-- ============================================
    We handle a break element by inserting an 
    empty <fo:block>.
    =============================================== -->

    <xsl:template match="br">
        <fo:block> </fo:block>
    </xsl:template>

    <!-- ============================================
    We render an <hr> with a leader.  Because <hr>
    is empty, we don't have to process any child
    elements. 
    =============================================== -->

    <xsl:template match="hr">
        <fo:block>
            <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    For the <img> element, we use the src attribute
    as it comes from HTML.  We also check for any 
    width and height attributes.  If those attributes
    are there, we try to use them; height="300px" is
    used as-is, while height="300" is converted to 
    the value "300px".
    =============================================== -->

    <xsl:template match="img">
        <fo:inline>
            <fo:external-graphic >
                <xsl:attribute name="src">
                    <xsl:value-of select="concat('images/',@src)" />
                </xsl:attribute>
                <xsl:if test="@width">
                    <xsl:attribute name="width">
                        <xsl:choose>
                            <xsl:when test="contains(@width, 'px')">
                                <xsl:value-of select="@width"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(@width, 'px')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@height">
                    <xsl:attribute name="height">
                        <xsl:choose>
                            <xsl:when test="contains(@height, 'px')">
                                <xsl:value-of select="@height"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(@height, 'px')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
                <xsl:attribute name="scaling">uniform</xsl:attribute>
            </fo:external-graphic>
        </fo:inline>
    </xsl:template>

</xsl:stylesheet>
