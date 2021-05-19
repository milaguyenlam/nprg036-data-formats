<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lang="http://example.org/lang">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>
	
	<!-- Fills in a language tag -->
	<xsl:function name="lang:addLang">
		<xsl:param name="langTag"/>
		<xsl:choose>
			<xsl:when test="langTag != ''">
				@<xsl:value-of select="langTag"/>
			</xsl:when>
			<xsl:otherwise>
				@en
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	<xsl:template match="/">
		@base &lt;http://example.org/&gt; .
		@prefix schema: &lt;http://schema.org/&gt; .
		@prefix frapo: &lt;http://purl.org/cerif/frapo&gt; .
		@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
		@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
		@prefix ex: &lt;http://example.org/ex/&gt; .

		ex:productionCapacity rdf:type xsd:integer .

		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="Product">
		&lt;#<xsl:value-of select="lower-case(Name)"/>&gt;
			a schema:Product ;
			schema:name "<xsl:value-of select="Name"/><xsl:value-of select="lang:addLang(Name/@lang)"/>" ;
			schema:gtin13 "<xsl:value-of select="Ean"/>" ;
			schema:description "<xsl:value-of select="Description"/><xsl:value-of select="lang:addLang(Name/@lang)"/>" ;
			
		<xsl:apply-templates/>

    <!-- TODO -->
    
	</xsl:template>

  <!-- TODO -->
  
	<xsl:template match="text()"/>
</xsl:stylesheet>