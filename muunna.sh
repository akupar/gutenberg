#!/bin/sh

for file in $(ls -1 suomi); do
    xalan -xsl muunna.xsl -in suomi/$file;
done | grep -v '^ *$' | tee output.txt
