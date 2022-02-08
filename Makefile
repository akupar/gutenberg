
all: build/index.html build/index-by-author.html build/index-by-lcsh.html build/index-by-lcc.html build/index.css build/index.js

build/index.html: data/catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl src/by-title.xsl -in data/catalog-fi.rdf -out build/index.html -param date "'"`date +%Y-%m-%d`"'"

build/index-by-author.html: data/catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl src/by-author.xsl -in data/catalog-fi.rdf -out build/index-by-author.html -param date "'"`date +%Y-%m-%d`"'"

build/index-by-lcsh.html: data/catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl src/by-lcsh.xsl -in data/catalog-fi.rdf -out build/index-by-lcsh.html -param date "'"`date +%Y-%m-%d`"'"

build/index-by-lcc.html: data/catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl src/by-lcc.xsl -in data/catalog-fi.rdf -out build/index-by-lcc.html -param date "'"`date +%Y-%m-%d`"'"

build/index.css: src/index.css
	cp src/index.css build/index.css

build/index.js: src/index.js
	cp src/index.js build/index.js

data/catalog-fi.rdf: data/rdf-files.tar.bz2
	@echo "Extract catalog"
	python3 src/extract.py data/rdf-files.tar.bz2 fi -o data/catalog-fi.rdf

data/rdf-files.tar.bz2:
	@echo "Downloading rdf-files.tar.bz2"
	cd data && wget https://gutenberg.org/cache/epub/feeds/rdf-files.tar.bz2
#	cd data && cp ../../rdf-files.tar.bz2 rdf-files.tar.bz2

