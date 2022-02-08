<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:pgterms="http://www.gutenberg.org/2009/pgterms/"
xmlns:dcterms="http://purl.org/dc/terms/"
>
  <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

  <xsl:template match="/rdf:RDF/*" priority="0">
  </xsl:template>
  
   <xsl:template match="/rdf:RDF/pgterms:ebook" priority="100">
     <xsl:variable name="id" select="substring-after(@rdf:about, 'ebooks/')"/>
*{{Kirjaviite 
 | Tekijä = <xsl:apply-templates select="dcterms:creator/pgterms:agent/pgterms:name"/> 
 | Nimeke = <xsl:apply-templates select="dcterms:title"/> 
 | Vuosi = <xsl:apply-templates select="dcterms:issued"/> 
 | Kappale = 
 | Sivu = 
 | Selite = Digitoitu versio, {{alkupteos|Julkaisija=|Julkaisupaikka=|Vuosi=}}
 | Julkaisupaikka = 
 | Julkaisija = <xsl:value-of select="dcterms:publisher"/> 
 | Tunniste = 
 | www = <xsl:value-of select="concat('https://gutenberg.org/ebooks/', $id)"/>
 | www-teksti = Project Gutenberg 
 | Tiedostomuoto = 
 | Viitattu = 
 | Kieli = 
 }}
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
