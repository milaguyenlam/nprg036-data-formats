<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lang="http://example.com/lang">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    <!-- Fills in a language tag -->
    <xsl:function name="lang:addLang">
        <xsl:param name="langTag"/>
        <xsl:choose>
            <xsl:when test="$langTag != ''">@<xsl:value-of select="$langTag"/></xsl:when>
            <xsl:otherwise>@en</xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:template match="Offers">@base &lt;http://example.com/&gt; .
@prefix schema: &lt;http://schema.org/&gt; .
@prefix frapo: &lt;http://purl.org/cerif/frapo&gt; .
@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix ex: &lt;http://example.com/ex/&gt; .
@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .

ex:productionCapacity a rdf:Property;
    rdfs:range xsd:nonNegativeInteger .

ex:id a rdf:Property;
    rdfs:range xsd:nonNegativeInteger .
<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="Offer">
&lt;http://example.com/offer/<xsl:value-of select="Id"/>&gt; a schema:Offer ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:startDate "<xsl:value-of select="FromDate"/>"^^xsd:date ;
    schema:endDate "<xsl:value-of select="ToDate"/>"^^xsd:date ;
    schema:price "<xsl:value-of select="Price"/>"^^xsd:decimal ;
    schema:discount "<xsl:value-of select="DiscountRate"/>"^^xsd:decimal ;
    schema:availability "<xsl:value-of select="Availability"/>"^^xsd:nonNegativeInteger ;
    <xsl:if test="Description">schema:description "<xsl:value-of select="Description"/>"<xsl:value-of select="lang:addLang(Description/@xml:lang)"/> ;</xsl:if>
    schema:offeredBy &lt;http://example.com/store/<xsl:value-of select="Store/Id"/>&gt; ;
    schema:itemOffered &lt;http://example.com/product/<xsl:value-of select="Product/Id"/>&gt; .
<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="Store">
&lt;http://example.com/store/<xsl:value-of select="Id"/>&gt; a schema:Store ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:branchOf &lt;http://example.com/vendor/<xsl:value-of select="Vendor/Id"/>&gt; ;
    schema:address "<xsl:value-of select="Address"/>" ;
    schema:openingHours "<xsl:value-of select="OpeningHours"/>"<xsl:value-of select="lang:addLang(OpeningHours/@xml:lang)"/> .
<xsl:for-each select="Rating">
&lt;http://example.com/storerating/<xsl:value-of select="Id"/>&gt; a schema:Rating ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:object &lt;http://example.com/store/<xsl:value-of select="../Id"/>&gt; ;
    schema:starRating "<xsl:value-of select="StarRating"/>"^^xsd:nonNegativeInteger .
</xsl:for-each>
<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="Vendor">
&lt;http://example.com/vendor/<xsl:value-of select="Id"/>&gt; a frapo:Vendor ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:image &lt;http://example.com/picture/<xsl:value-of select="Picture/Id"/>&gt; ;
    schema:name "<xsl:value-of select="Name"/>" ;
    schema:leiCode "<xsl:value-of select="Dic"/>"^^xsd:nonNegativeInteger .
    <xsl:for-each select="Rating">
&lt;http://example.com/vendorrating/<xsl:value-of select="Id"/>&gt; a schema:Rating ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:object &lt;http://example.com/vendor/<xsl:value-of select="../Id"/>&gt; ;
    schema:starRating "<xsl:value-of select="StarRating"/>"^^xsd:nonNegativeInteger .
</xsl:for-each>
    <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="Product">
&lt;http://example.com/product/<xsl:value-of select="Id"/>&gt; a schema:Product ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:name "<xsl:value-of select="Name"/>"<xsl:value-of select="lang:addLang(Name/@xml:lang)"/> ;
    schema:gtin13 "<xsl:value-of select="Ean"/>" ;
    schema:description "<xsl:value-of select="Description"/>"<xsl:value-of select="lang:addLang(Description/@xml:lang)"/> ;
    schema:manufacturer &lt;http://example.com/producer/<xsl:value-of select="Producer/Id"/>&gt; ;
    <xsl:for-each select="Category">schema:category &lt;http://example.com/category/<xsl:value-of select="Id"/>&gt; ;</xsl:for-each>
    schema:image &lt;http://example.com/picture/<xsl:value-of select="Picture/Id"/>&gt; .
    <xsl:for-each select="Rating">
&lt;http://example.com/productrating/<xsl:value-of select="Id"/>&gt; a schema:Rating ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:object &lt;http://example.com/product/<xsl:value-of select="../Id"/>&gt; ;
    schema:starRating "<xsl:value-of select="StarRating"/>"^^xsd:nonNegativeInteger .
</xsl:for-each>
<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="Picture">
&lt;http://example.com/picture/<xsl:value-of select="Id"/>&gt; a schema:ImageObject ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:height "<xsl:value-of select="Height"/>"^^xsd:nonNegativeInteger ;
    schema:width "<xsl:value-of select="Width"/>"^^xsd:nonNegativeInteger ;
    schema:url "<xsl:value-of select="Uri"/>" .
    </xsl:template>
    <xsl:template match="Category">
&lt;http://example.com/category/<xsl:value-of select="Id"/>&gt; a schema:ProductGroup ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    <xsl:if test="ParentCategory">schema:isPartOf &lt;http://example.com/category/<xsl:value-of select="ParentCategory/Id"/>&gt; ;
    </xsl:if><xsl:for-each select="SynonymName">
    schema:alternateName "<xsl:value-of select="."/>"<xsl:value-of select="lang:addLang(@xml:lang)"/> ;</xsl:for-each>
    schema:name "<xsl:value-of select="InternalName"/>"<xsl:value-of select="lang:addLang(InternalName/@xml:lang)"/> .
<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ParentCategory">
&lt;http://example.com/category/<xsl:value-of select="Id"/>&gt; a schema:ProductGroup ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;<xsl:for-each select="SynonymName">
    schema:alternateName "<xsl:value-of select="."/>"<xsl:value-of select="lang:addLang(@xml:lang)"/> ;</xsl:for-each>
    schema:name "<xsl:value-of select="InternalName"/>"<xsl:value-of select="lang:addLang(InternalName/@xml:lang)"/> .
    </xsl:template>
    <xsl:template match="Producer">
&lt;http://example.com/producer/<xsl:value-of select="Id"/>&gt; a frapo:Manufacturer ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:name "<xsl:value-of select="Name"/>" ;
    schema:leiCode "<xsl:value-of select="Dic"/>"^^xsd:nonNegativeInteger ;
    schema:image &lt;http://example.com/picture/<xsl:value-of select="Picture/Id"/>&gt; ;
    ex:productionCapacity"<xsl:value-of select="ProductionCapacity"/>"^^xsd:nonNegativeInteger .
        <xsl:for-each select="Rating">
&lt;http://example.com/producerrating/<xsl:value-of select="Id"/>&gt; a schema:Rating ;
    ex:id "<xsl:value-of select="Id"/>"^^xsd:nonNegativeInteger ;
    schema:object &lt;http://example.com/producer/<xsl:value-of select="../Id"/>&gt; ;
    schema:starRating "<xsl:value-of select="StarRating"/>"^^xsd:nonNegativeInteger .
    <xsl:apply-templates/>
</xsl:for-each>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
