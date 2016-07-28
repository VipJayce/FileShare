<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl">

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="modules">
	<UL>
	<xsl:if test="context()/module">
	<xsl:for-each select="module">
	<li/>
		<a>
		<xsl:attribute name="href"><xsl:value-of select="url"/></xsl:attribute>
		<xsl:attribute name="target"><xsl:value-of select="url"/></xsl:attribute>
		<xsl:value-of select="name"/>
		</a>
	</xsl:for-each>
	</xsl:if>
	</UL>
</xsl:template>

</xsl:stylesheet>
