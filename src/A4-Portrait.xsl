<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stlyesheet [
<!ENTITY emsp "&#x2003;" >
]>
<!--
    Document   : A4-Portrait-Book.xsl
    Author     : richard
    Description:
        A4 Portrait Book document definitions and FO creation to flow level
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

    <!--  ==============================================================
       Sets of attributes for page layout definitions
    =============================================================== -->
    
    <xsl:variable name="COLUMN-COUNT">1</xsl:variable>
    <xsl:variable name="STD-MARGIN">0.2</xsl:variable>
    <xsl:variable name="STD-MARGIN-UNIT">in</xsl:variable>

    <xsl:attribute-set name="page">
        <xsl:attribute name="page-height">21.0cm</xsl:attribute>
        <xsl:attribute name="page-width">29.7cm</xsl:attribute>
        <xsl:attribute name="margin-top">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>   
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>    
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="concat($STD-MARGIN,$STD-MARGIN-UNIT)"/>    
        </xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="column">
        <xsl:attribute name="column-count">
            <xsl:value-of select="$COLUMN-COUNT"/>
        </xsl:attribute>
        <xsl:attribute name="column-gap">
            <xsl:value-of select="concat($STD-MARGIN*2,$STD-MARGIN-UNIT)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    
    
    <!--  ==============================================================
       Sets of attributes for page layout definitions
    =============================================================== -->
    
    <xsl:attribute-set name="a4">
        <xsl:attribute name="page-height">29.7cm</xsl:attribute>
        <xsl:attribute name="page-width">21cm</xsl:attribute>
        <xsl:attribute name="margin-top">0.75in</xsl:attribute>
        <xsl:attribute name="margin-bottom">0.2in</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-atts-even">
        <xsl:attribute name="margin-left">1in</xsl:attribute>
        <xsl:attribute name="margin-right">1.25in</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-atts-odd">
        <xsl:attribute name="margin-left">1.25in</xsl:attribute>
        <xsl:attribute name="margin-right">1in</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="region-atts">
        <xsl:attribute name="margin-bottom">0.5in</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="region-after-atts">
        <xsl:attribute name="extent">0.4in</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="column">
        <xsl:attribute name="column-count">
            <xsl:value-of select="$COLUMN-COUNT"/>
        </xsl:attribute>
        <xsl:attribute name="column-gap">
            <xsl:value-of select="concat($STD-MARGIN*2,$STD-MARGIN-UNIT)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    
    <!--  ==============================================================
       Template to define the page definitions which define the layout
       of this book .
    =============================================================== -->
    
    <xsl:template match="/publication">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" >
            <fo:layout-master-set>
                        <fo:simple-page-master master-name="firsteven" xsl:use-attribute-sets="a4 page-atts-even">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts" />
                            <fo:region-after region-name="firsteven-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="firstodd" xsl:use-attribute-sets="a4 page-atts-odd">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts" />
                            <fo:region-after region-name="firstodd-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="onlyeven" xsl:use-attribute-sets="a4 page-atts-even">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts" />
                            <fo:region-after region-name="onlyeven-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="onlyodd" xsl:use-attribute-sets="a4 page-atts-odd">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts" />
                            <fo:region-after region-name="onlyodd-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="odd" xsl:use-attribute-sets="a4 page-atts-odd">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts"/>
                            <fo:region-after region-name="odd-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="even" xsl:use-attribute-sets="a4 page-atts-even">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts"/>
                            <fo:region-after region-name="even-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="lasteven" xsl:use-attribute-sets="a4 page-atts-even">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts"/>
                            <fo:region-after region-name="lasteven-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="lastodd" xsl:use-attribute-sets="a4 page-atts-even">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts"/>
                            <fo:region-after region-name="lastodd-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                        <fo:simple-page-master master-name="blank" xsl:use-attribute-sets="a4 page-atts-even">
                            <fo:region-body region-name="body" xsl:use-attribute-sets="region-atts"/>
                            <fo:region-after region-name="blank-after" xsl:use-attribute-sets="region-after-atts" />
                        </fo:simple-page-master>
                <fo:page-sequence-master master-name="bookpart">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="onlyeven" page-position="only"  odd-or-even="even"/>
                        <fo:conditional-page-master-reference master-reference="onlyodd" page-position="only"  odd-or-even="odd"/>
                        <fo:conditional-page-master-reference master-reference="firsteven" page-position="first"  odd-or-even="even"/>
                        <fo:conditional-page-master-reference master-reference="firstodd" page-position="first"  odd-or-even="odd"/>
                        <fo:conditional-page-master-reference master-reference="odd" odd-or-even="odd" page-position="rest" />
                        <fo:conditional-page-master-reference master-reference="even" odd-or-even="even" page-position="rest" />
                        <fo:conditional-page-master-reference master-reference="blank" blank-or-not-blank="blank" page-position="last"/> 
                        <fo:conditional-page-master-reference master-reference="lasteven" odd-or-even="even" page-position="last" />
                        <fo:conditional-page-master-reference master-reference="lastodd" odd-or-even="odd" page-position="last" />
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            <xsl:apply-templates select="*"/>
        </fo:root>
    </xsl:template>
    
    <xsl:template name="allempty-footer">
        <fo:static-content flow-name="firsteven-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="firstodd-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="onlyeven-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="onlyodd-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="even-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="odd-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="lasteven-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="lastodd-after" >
            <fo:block/>
        </fo:static-content>
        <fo:static-content flow-name="blank-after" >
            <fo:block/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="pagenumbered-footer">
        <fo:static-content flow-name="firsteven-after">
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="left" xsl:use-attribute-sets="footerfont">
                <fo:page-number/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="firstodd-after">
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="right" xsl:use-attribute-sets="footerfont">
                <fo:page-number/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="onlyeven-after">
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="left" xsl:use-attribute-sets="footerfont">
                <fo:page-number/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="onlyodd-after">
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="right" xsl:use-attribute-sets="footerfont">
                <fo:page-number/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="even-after">
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="left" xsl:use-attribute-sets="footerfont">
                <fo:page-number/>&emsp;|&emsp;<fo:retrieve-marker retrieve-class-name="title"/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="odd-after">
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="right" xsl:use-attribute-sets="footerfont">
                <fo:retrieve-marker retrieve-class-name="title"/>&emsp;|&emsp;<fo:page-number/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="lasteven-after" >
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="left" xsl:use-attribute-sets="footerfont">
                <fo:page-number/>&emsp;|&emsp;<fo:retrieve-marker retrieve-class-name="title"/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="lastodd-after" >
            <fo:block>
                <fo:leader leader-pattern="rule" leader-length.maximum="100%" leader-length.optimum="100%"/>
            </fo:block>
            <fo:block text-align="right" xsl:use-attribute-sets="footerfont">
                <fo:retrieve-marker retrieve-class-name="title"/>&emsp;|&emsp;<fo:page-number/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="blank-after" >
            <fo:block/>
        </fo:static-content>
    </xsl:template>
            
</xsl:stylesheet>
