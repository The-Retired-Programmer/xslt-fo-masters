<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : htmltags_decorators.xsl
    Author     : richard
    Description:
        templates to process html "decorator" tags (to FO)
        
        This stylesheet was derived from 
    a stylesheet written by Doug Tidwell,
    dtidwell@us.ibm.com (ibm.com/developerWorks)
    
    Extracted and updated by Richard Linsdale
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    
    <!-- ============================================
      We render an address element in italics.
    =============================================== -->

    <xsl:template match="address">
        <fo:block font-style="italic" space-after="12pt">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    For bold elements, we just change the font-weight.
    =============================================== -->

    <xsl:template match="b">
        <fo:inline font-weight="bold">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    A blockquote is indented on both sides.
    =============================================== -->

    <xsl:template match="blockquote">
        <fo:block start-indent="1.5cm" end-indent="1.5cm"
                  space-after="12pt">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    The <cite> element is rendered in italics, 
    unless it's inside an italic (<i>) element. 
    We use the parent axis to check this. 
    =============================================== -->

    <xsl:template match="cite">
        <xsl:choose>
            <xsl:when test="parent::i">
                <fo:inline font-style="normal">
                    <xsl:apply-templates select="*|text()"/>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline font-style="italic">
                    <xsl:apply-templates select="*|text()"/>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ============================================
    We render <code> inline in a "code" font.
    =============================================== -->

    <xsl:template match="code">
        <fo:inline xsl:use-attribute-sets="codefont">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    We don't do anything with the <dl> element, we
    just handle the elements it contains.  Notice
    that we're ignoring any text that appears 
    in the <dl> itself; I'm not sure if that's
    the right call.
    =============================================== -->

    <xsl:template match="dl">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <!-- ============================================
    A definition term is rendered in bold.  We 
    specify keep-with-next here, although it doesn't
    always work with FOP.
    =============================================== -->

    <xsl:template match="dt">
        <fo:block font-weight="bold" space-after="2pt"
                  keep-with-next.within-column="always">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    We handle each <dd> element as an indented block
    beneath the defined term.  If the following 
    element is another <dd>, that means it's another
    definition for the same term.  In that case, 
    we don't put as much vertical space after the 
    block. 
    =============================================== -->

    <xsl:template match="dd">
        <fo:block start-indent="1cm">
            <xsl:attribute name="space-after">
                <xsl:choose>
                    <xsl:when test="name(following::*[1]) = 'dd'">
                        <xsl:text>3pt</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>12pt</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    The HTML <em> element is typically rendered in 
    italics. 
    =============================================== -->

    <xsl:template match="em">
        <fo:inline font-style="italic">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    Italics.  You can't get much simpler than that.
    =============================================== -->

    <xsl:template match="i">
        <fo:inline font-style="italic">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    The <kbd> element is in a code font.
    =============================================== -->

    <xsl:template match="kbd">
        <fo:inline xsl:use-attribute-sets="codefont" font-weight="bold" >
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    The <nobr> element renders differently in FOP 
    1.x than it did in earlier versions. Currently
    FOP does not support the wrap-option="no-wrap" 
    attribute on the <fo:inline> element correctly, 
    so we put it in an <fo:block> element. If you're 
    using another XSL-FO processor, try this with the 
    <fo:inline> element instead to see if it 
    renders correctly. 
    =============================================== -->

    <xsl:template match="nobr">
        <fo:block wrap-option="no-wrap">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    Your basic paragraph.
    =============================================== -->

    <xsl:template match="p">
        <fo:block xsl:use-attribute-sets="parafont">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    Preformatted text is rendered in the code
    font.  We also have to set the wrap-option
    and white-space-collapse properties.  
    =============================================== -->

    <xsl:template match="pre">
        <fo:block xsl:use-attribute-sets="codefont"
                  white-space-collapse="false" wrap-option="no-wrap"
                  linefeed-treatment="preserve" white-space-treatment="preserve">
            <xsl:apply-templates select="*|text()"/>
        </fo:block>
    </xsl:template>

    <!-- ============================================
    Sample text is rendered in a code font. 
    =============================================== -->

    <xsl:template match="samp">
        <fo:inline xsl:use-attribute-sets="codefont">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    For strikethrough text, we use the text-decoration
    property.  
    =============================================== -->

    <xsl:template match="strike">
        <fo:inline text-decoration="line-through">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    Strongly emphasized text is simply rendered
    in bold. 
    =============================================== -->

    <xsl:template match="strong">
        <fo:inline font-weight="bold">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    For subscript text, we use the vertical-align
    property and decrease the font size.  
    =============================================== -->

    <xsl:template match="sub">
        <fo:inline vertical-align="sub" font-size="75%">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    Superscript text changes the vertical-align
    property also, and uses a smaller font.
    =============================================== -->

    <xsl:template match="sup">
        <fo:inline vertical-align="super" font-size="75%">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    Teletype text is rendered in a code font.
    =============================================== -->

    <xsl:template match="tt">
        <fo:inline xsl:use-attribute-sets="codefont">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>
  
    <!-- ============================================
    For underlined text, we use the text-decoration
    property.
    =============================================== -->

    <xsl:template match="u">
        <fo:inline text-decoration="underline">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

    <!-- ============================================
    The <var> element is rendered in italics. 
    =============================================== -->

    <xsl:template match="var">
        <fo:inline font-style="italic">
            <xsl:apply-templates select="*|text()"/>
        </fo:inline>
    </xsl:template>

</xsl:stylesheet>
