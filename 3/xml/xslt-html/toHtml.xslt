<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output name="index" method="html" encoding="UTF-8" indent="yes"/>
	<xsl:output name="offer" method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="Offers">
		<xsl:result-document href="index.html" format="index">
			<html>
				<head>
					<title>
                    Best good picker
                </title>
				</head>
				<body>
					<h1>
                    Select offer
                </h1>
					<xsl:for-each select="Offer">
						<p>
							<a href="Offer{position()}.html">
									<xsl:value-of select="Product/Name"/> at <xsl:value-of select="Store/Vendor/Name"/> - <xsl:value-of select="Store/Address"/>
							</a>
						</p>
						<xsl:result-document href="Offer{position()}.html" format="offer">
							<xsl:apply-templates select="Product"/>
						</xsl:result-document>
					</xsl:for-each>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>
	<xsl:template match="Product">
		<html>
			<head>
				<title>
					<xsl:value-of select="../Store/Vendor/Name"/> | <xsl:value-of select="../Product/Name"/>
				</title>
				<!-- For barecode printing -->
				<script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.0/dist/JsBarcode.all.min.js"/>
				<style>
div {
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
  align-content: start;
}
.sale {
  color: red;
  transform: rotate(20deg);
}
				</style>
			</head>
			<body>
				<h1>
					<xsl:value-of select="../Product/Name"/> at <xsl:value-of select="../Store/Vendor/Name"/> offer
                </h1>
                <p><xsl:value-of select="../Store/Address"/></p>
				<div>
					<span>
			<h2>
				<xsl:value-of select="Name"/>
				<p class="sale">SALE <xsl:value-of select="../DiscountRate * 100"/> %</p>
			</h2>
			<p> &gt; <xsl:value-of select="Category/InternalName"/> &gt; <xsl:value-of select="Category/ParentCategory/InternalName"/>
			</p>
			<img src="{Picture/Uri}" alt="{Name}" width="{Picture/Width}" height="{Picture/Height}"/>
			<p>
				<xsl:value-of select="Description"/>
			</p>
			<table rules="all" style="border: 1px solid black">
				<tr>
					<th colspan="2">
						<xsl:value-of select="Name"/> rating</th>
				</tr>
				<tr>
					<td>Average</td>
					<td>
						<xsl:value-of select="format-number(sum(Rating) div count(Rating),'#.#')"/>
					</td>
				</tr>
				<tr style="border-bottom:1px solid black">
					<td colspan="2"/>
				</tr>
				<tr>
					<td>Excellent</td>
					<td>
						<xsl:value-of select="count(Rating[. = 5])"/>
					</td>
				</tr>
				<tr>
					<td>Very Good</td>
					<td>
						<xsl:value-of select="count(Rating[. = 4])"/>
					</td>
				</tr>
				<tr>
					<td>Good</td>
					<td>
						<xsl:value-of select="count(Rating[. = 3])"/>
					</td>
				</tr>
				<tr>
					<td>Fair</td>
					<td>
						<xsl:value-of select="count(Rating[. = 2])"/>
					</td>
				</tr>
				<tr>
					<td>Poor</td>
					<td>
						<xsl:value-of select="count(Rating[. = 1])"/>
					</td>
				</tr>
			</table>
			<svg id="{concat('barcode_', Ean)}"/>
			<script>
			JsBarcode("#barcode_<xsl:value-of select="Ean"/>", "<xsl:value-of select="Ean"/>");
        </script>
		</span>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>