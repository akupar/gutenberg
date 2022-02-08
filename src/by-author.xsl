<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:pgterms="http://www.gutenberg.org/2009/pgterms/"
               xmlns:dcterms="http://purl.org/dc/terms/"
               xmlns:xhtml="http://www.w3.org/1999/xhtml"
               xmlns:dcam="http://purl.org/dc/dcam/"
               xmlns:ext="http://exslt.org/common"
               exclude-result-prefixes="ext"
               >
  <xsl:param name="date" />
  <xsl:output method="html" indent="yes"/>

  
  <xsl:variable name="most-recent">
    <xsl:for-each select="/rdf:RDF/pgterms:ebook/dcterms:issued">
      <xsl:sort data-type="text" order="descending"/>
      <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
    </xsl:for-each>
  </xsl:variable>


  <xsl:template match="/rdf:RDF" priority="0">
    
    <!-- Create table rows separately so they can be sorted before output -->
    <xsl:variable name="pass-1">
      <tmp>
        <xsl:apply-templates select="pgterms:ebook"/>
      </tmp>        
    </xsl:variable>

    
    <xsl:variable name="nodeset-pass-1"
                  select="ext:node-set($pass-1)"/>

    <!-- Create html file -->
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;
</xsl:text>
    <html>
      <head>
        <title>Project Gutenbergin suomenkieliset kirjat</title>
        <xsl:copy-of select="document('html-template.html')/xhtml:html/xhtml:head/*"/>
      </head>
      <body>
        <h1>Project Gutenbergin suomenkieliset kirjat</h1>
        <p>
          Päivitetty <xsl:value-of select="$date"/>. Viimeisin luettelon teos julkaistu <xsl:value-of select="$most-recent"/>.
        </p>
        
        <table>
          <thead>
            <tr>
              <td id="col-author"><span class="header-sorted">Tekijä</span></td>
              <td id="col-title"><span class="header-unsorted">Nimeke</span></td>
              <td id="col-lcsh"><span class="header-unsorted">LCSH</span></td>
              <td id="col-lcc"><span class="header-unsorted">LCC</span></td>
              <td>Julkaistu</td>
            </tr>
          </thead>
          <tbody>
            <!-- Sorted rows -->
            <xsl:apply-templates select="$nodeset-pass-1/*"/>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="/rdf:RDF/*" priority="0">
  </xsl:template>

  <xsl:template match="pgterms:ebook" priority="100">
    <xsl:variable name="id" select="substring-after(@rdf:about, 'ebooks/')"/>
    <xsl:for-each select="dcterms:creator">
        <tr>
          <td><xsl:apply-templates select="./pgterms:agent/pgterms:name"/></td>
          <td><a href="{concat('https://gutenberg.org/ebooks/', $id)}"><xsl:apply-templates select="../dcterms:title"/></a></td>
          <td><xsl:apply-templates select="../dcterms:subject/rdf:Description/dcam:memberOf[@rdf:resource='http://purl.org/dc/terms/LCSH']"/></td>
          <td><xsl:apply-templates select="../dcterms:subject/rdf:Description/dcam:memberOf[@rdf:resource='http://purl.org/dc/terms/LCC']"/></td>
          <td><xsl:apply-templates select="../dcterms:issued"/></td>
        </tr>
    </xsl:for-each>
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
    <xsl:variable name="author" select="." />
    <!-- Add anchor for to first element -->
    <xsl:choose>
      <xsl:when test="position() = 1 and position() = last()">
        <span id="{$author}"><xsl:value-of select="$author"/></span>
      </xsl:when>
      <xsl:when test="position() = 1">
        <span id="{$author}"><xsl:value-of select="$author"/></span> &amp; 
      </xsl:when>
      <xsl:when test="position() = last()">
        <span><xsl:value-of select="$author"/></span>
      </xsl:when>
      <xsl:otherwise>
        <span><xsl:value-of select="$author"/></span> &amp; 
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="dcam:memberOf[@rdf:resource='http://purl.org/dc/terms/LCSH']">
        <xsl:variable name="classif" select="../rdf:value" />
        <xsl:choose>
          <xsl:when test="position() != last()">
            <span class="lcsh-tag"><xsl:value-of select="$classif"/></span><br/>
          </xsl:when>
          <xsl:otherwise>
            <span class="lcsh-tag"><xsl:value-of select="$classif"/></span>
          </xsl:otherwise>
        </xsl:choose>
  </xsl:template>

  <xsl:template match="dcam:memberOf[@rdf:resource='http://purl.org/dc/terms/LCC']">
        <xsl:variable name="classif" select="../rdf:value" />
        <span class="lcc-tag"><xsl:value-of select="$classif"/></span>
  </xsl:template>

  
  <!-- Row sorting -->
  
  <xsl:template match="tmp">
    <xsl:for-each select="tr">
      <xsl:sort select="td[1]"/>
      <tr><xsl:copy-of select="*" /></tr>
    </xsl:for-each>
  </xsl:template>



</xsl:transform>
