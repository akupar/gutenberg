

index.html: catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl by-title.xsl -in catalog-fi.rdf -out index.html -param date "'"`date +%Y-%m-%d`"'"

index-by-author.html: catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl by-author.xsl -in catalog-fi.rdf -out index-by-author.html -param date "'"`date +%Y-%m-%d`"'"

index-by-lcsh.html: catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl by-lcsh.xsl -in catalog-fi.rdf -out index-by-lcsh.html -param date "'"`date +%Y-%m-%d`"'"

index-by-lcc.html: catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl by-lcc.xsl -in catalog-fi.rdf -out index-by-lcc.html -param date "'"`date +%Y-%m-%d`"'"


catalog-fi.rdf: rdf-files.tar.bz2
	@echo "Extract catalog"
	python3 extract.py rdf-files.tar.bz2 fi -o catalog-fi.rdf

rdf-files.tar.bz2:
	@echo "Downloading rdf-files.tar.bz2"
	wget https://gutenberg.org/cache/epub/feeds/rdf-files.tar.bz2

