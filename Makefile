

index.html: catalog-fi.rdf
	@echo "Converting catalog to html"
	xalan -xsl muunna.xsl -in catalog-fi.rdf -out index.html -param date "'"`date +%Y-%m-%d`"'"

catalog-fi.rdf: rdf-files.tar.bz2
	@echo "Extract catalog"
	python3 extract.py rdf-files.tar.bz2 fi -o catalog-fi.rdf

rdf-files.tar.bz2:
	@echo "Downloading rdf-files.tar.bz2"
	cp libs/rdf-files.tar.bz2 .
#wget https://gutenberg.org/cache/epub/feeds/rdf-files.tar.bz2
