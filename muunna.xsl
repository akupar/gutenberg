<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:pgterms="http://www.gutenberg.org/2009/pgterms/"
               xmlns:dcterms="http://purl.org/dc/terms/"
               xmlns:xhtml="http://www.w3.org/1999/xhtml"
               >
  <xsl:output method="html" indent="yes"/>


  <xsl:template match="/rdf:RDF" priority="0">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;
</xsl:text>
    <html>
      <head>
        <title>Project Gutenbergin suomenkieliset kirjat</title>
        <xsl:copy-of select="document('html-template.html')/xhtml:html/xhtml:head/*"/>
      </head>
      <body>
        <table>
          <thead>
            <tr>
              <td>Tekijä</td>
              <td>Nimeke</td>
              <td>Julkaistu</td>
              <td>Julkaisija</td>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="pgterms:ebook"/>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="/rdf:RDF/*" priority="0">
  </xsl:template>

  <xsl:template match="pgterms:ebook" priority="100">
    <xsl:variable name="id" select="substring-after(@rdf:about, 'ebooks/')"/>
    <tr>
      <td><xsl:apply-templates select="dcterms:creator/pgterms:agent/pgterms:name"/></td>
      <td><a href="{concat('https://gutenberg.org/ebooks/', $id)}"><xsl:apply-templates select="dcterms:title"/></a></td>
      <td><xsl:apply-templates select="dcterms:issued"/></td>
      <td><xsl:value-of select="dcterms:publisher"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="dcterms:title">
    <xsl:if test="position() = last()">
      <xsl:value-of select="."/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="dcterms:issued">
    <xsl:value-of select="substring-before(., '-')"/>
  </xsl:template>

  <xsl:template match="dcterms:creator/pgterms:agent/pgterms:name">
    <xsl:choose>
      <xsl:when test="position() != last()">
        <xsl:value-of select="concat(., ' &amp; ')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>




</xsl:transform>
