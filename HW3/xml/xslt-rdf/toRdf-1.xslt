<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lang="http://example.org/lang">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>
	<!-- Fills in a language tag -->
	<xsl:function name="lang:addLang">
		<xsl:param name="langTag"/>
		<xsl:choose>
			<xsl:when test="$langTag != ''">@<xsl:value-of select="$langTag"/></xsl:when>
			<xsl:otherwise>@en</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:template match="Offers">@base &lt;http://example.org/&gt; .
@prefix schema: &lt;http://schema.org/&gt; .
@prefix frapo: &lt;http://purl.org/cerif/frapo&gt; .
@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix ex: &lt;http://example.org/ex/&gt; .

ex:productionCapacity rdf:type xsd:integer .
<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="Offer">
&lt;#<xsl:value-of select="translate(lower-case(Product/Name), ' ', '_')"/>-offer-<xsl:value-of select="translate(Store/Vendor/Name, ' ', '_')"/>-<xsl:value-of select="translate(Store/Address, ' ', '_')"/>&gt;
	a schema:Offer ;
	schema:startDate "<xsl:value-of select="FromDate"/>"^^xsd:date ;
	schema:endDate "<xsl:value-of select="ToDate"/>"^^xsd:date ;
	schema:price "<xsl:value-of select="Price"/>" ;
	schema:discount "<xsl:value-of select="DiscountRate"/>" ;
	schema:availability "<xsl:value-of select="Availability"/>"<xsl:value-of select="lang:addLang(Availability/@lang)"/> ;
	schema:description "<xsl:value-of select="Description"/>"<xsl:value-of select="lang:addLang(Description/@lang)"/> ;
	schema:offeredBy &lt;#<xsl:value-of select="translate(Store/Vendor/Name, ' ', '_')"/>-<xsl:value-of select="translate(Store/Address, ' ', '_')"/>&gt; ;
	schema:itemOffered &lt;#<xsl:value-of select="translate(lower-case(Product/Name), ' ', '_')"/>&gt; .
<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="Store">
&lt;#<xsl:value-of select="translate(lower-case(Vendor/Name), ' ', '_')"/>-<xsl:value-of select="translate(Address, ' ', '_')"/>&gt;
	a schema:Store ;
	schema:branchOf &lt;#<xsl:value-of select="translate(lower-case(Vendor/Name), ' ', '_')"/>&gt; ;
	schema:address "<xsl:value-of select="Address"/>"<xsl:value-of select="lang:addLang(Address/@lang)"/> ;
	<xsl:for-each select="Rating">schema:rating "<xsl:value-of select="."/>" ;
	</xsl:for-each>
	schema:openingHours "<xsl:value-of select="OpeningHours"/>"<xsl:value-of select="lang:addLang(OpeningHours/@lang)"/> .
<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="Vendor">
&lt;#<xsl:value-of select="translate(lower-case(Name), ' ', '_')"/>&gt;
	a frapo:Vendor ;
	schema:name "<xsl:value-of select="Name"/>"<xsl:value-of select="lang:addLang(Name/@lang)"/> ;
	<xsl:for-each select="Rating">schema:rating "<xsl:value-of select="."/>" ;
	</xsl:for-each>
	schema:leiCode "<xsl:value-of select="Dic"/>" .
	</xsl:template>
	<xsl:template match="Product">
&lt;#<xsl:value-of select="translate(lower-case(Name), ' ', '_')"/>&gt;
	a schema:Product ;
	schema:name "<xsl:value-of select="Name"/>"<xsl:value-of select="lang:addLang(Name/@lang)"/> ;
	schema:gtin13 "<xsl:value-of select="Ean"/>" ;
	schema:description "<xsl:value-of select="Description"/>"<xsl:value-of select="lang:addLang(Description/@lang)"/> ;
	<xsl:for-each select="Rating">schema:rating "<xsl:value-of select="."/>" ;
	</xsl:for-each>
	schema:manufacturer &lt;#<xsl:value-of select="translate(lower-case(Producer/Name), ' ', '_')"/>&gt; ;
	<xsl:for-each select="Category">schema:category &lt;#<xsl:value-of select="translate(lower-case(InternalName), ' ', '_')"/>&gt; ;
	</xsl:for-each>
	schema:schema:image &lt;#<xsl:value-of select="translate(lower-case(Name), ' ', '_')"/>-image&gt; .
<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="Picture">
&lt;#<xsl:value-of select="translate(lower-case(../Name), ' ', '_')"/>-image&gt;	
	a schema:ImageObject ;
    schema:height "<xsl:value-of select="Height"/>" ;
    schema:width "<xsl:value-of select="Width"/>" ;
    schema:url "<xsl:value-of select="Uri"/>" .
	</xsl:template>
	<xsl:template match="Category">
&lt;#<xsl:value-of select="translate(lower-case(InternalName), ' ', '_')"/>&gt;
    a schema:ProductGroup ;
    <xsl:if test="ParentCategory">schema:isPartOf &lt;#<xsl:value-of select="translate(lower-case(ParentCategory/InternalName), ' ', '_')"/>&gt; ;</xsl:if>
    	<xsl:for-each select="SynonymName">schema:alternateName "<xsl:value-of select="."/>"<xsl:value-of select="lang:addLang(@lang)"/> ;
	</xsl:for-each>
    schema:name "<xsl:value-of select="InternalName"/>"<xsl:value-of select="lang:addLang(InternalName/@lang)"/> .    
<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="ParentCategory">
&lt;#<xsl:value-of select="translate(lower-case(InternalName), ' ', '_')"/>&gt;
    a schema:ProductGroup ;
    	<xsl:for-each select="SynonymName">schema:alternateName "<xsl:value-of select="."/>"<xsl:value-of select="lang:addLang(@lang)"/> ;
	</xsl:for-each>
	schema:name "<xsl:value-of select="InternalName"/>"<xsl:value-of select="lang:addLang(InternalName/@lang)"/> .
	</xsl:template>
	<xsl:template match="Producer">
&lt;#<xsl:value-of select="translate(lower-case(Name), ' ', '_')"/>&gt;
    a frapo:Manufacturer ;
    schema:name "<xsl:value-of select="Name"/>"<xsl:value-of select="lang:addLang(Name/@lang)"/> ;
    schema:leiCode "<xsl:value-of select="Dic"/>" ;
	<xsl:for-each select="Rating">schema:rating "<xsl:value-of select="."/>" ;
	</xsl:for-each>
    ex:productionCapacity"<xsl:value-of select="ProductionCapacity"/>" .
	</xsl:template>
	<xsl:template match="text()"/>
</xsl:stylesheet>