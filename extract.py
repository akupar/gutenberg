import argparse
import re
import sys
import tarfile
import xml.etree.ElementTree as ET


prefix_map = {
    "dcterms": "http://purl.org/dc/terms/",
    "pgterms": "http://www.gutenberg.org/2009/pgterms/",
    "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
}

namespaces = {
    "http://purl.org/dc/terms/": "dcterms",
    "http://www.gutenberg.org/2009/pgterms/" : "pgterms",
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#" : "rdf",
}

def innertext(tag):
  return (tag.text or '') + ''.join(innertext(e) for e in tag) + (tag.tail or '')


def read_file(filename):
    inp = tarfile.TarFile.bz2open(filename)
    for info in inp:
        if info.isfile():
            f = inp.extractfile(info)
            data = f.read()
            yield data
    inp.close()
    
def read_lang_file(filename, lang):
    for filedata in read_file(sys.argv[1]):
            
        root = ET.fromstring(filedata)
        langelems = root.findall('.//pgterms:ebook/dcterms:language', prefix_map)
        langtext = ";".join(map(lambda elem: innertext(elem), langelems))

        if re.search(r"\b" + lang + r"\b", langtext):
            yield root


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Selects items in a given language in the catalog and writes them to a new file.')
    
    parser.add_argument(type=str,
                        help='Input file (tar.bz2)',
                        dest='INPUT')
    
    parser.add_argument(type=str,
                        help='Language (iso code)',
                        dest='LANG')
    
    parser.add_argument('-o', '--output', type=str,
                        help='Output file')
    
    try:
        args = parser.parse_args()
    except:
        exit(1)
        
    
    inputfile = args.INPUT
    lang = args.LANG
    outputfile = args.output

    if not outputfile or outputfile == '-':
        output = sys.stdout
    else:
        output = open(outputfile, 'wb')     
    
    newroot = None
    count = 0
    count
    prevlen = 0
    sys.stdout.write("Extracting ")
    for xmlroot in read_lang_file(inputfile, lang):
        if not newroot:
            newroot = xmlroot
        else:
            ebook = xmlroot.findall('.//pgterms:ebook', prefix_map)
            assert len(ebook) == 1, "Monta ebookia"
            newroot.append(ebook[0])
            sys.stdout.write("\b"*prevlen)
            sys.stdout.write(str(count))
            sys.stdout.flush()
            prevlen = len(str(count))
        count += 1
        
    sys.stdout.write("\n")        

    tree = ET.ElementTree(newroot)
    tree.write(output, encoding="utf8", xml_declaration=True)

    if output != sys.stdout:
        output.close()

        

        

            



    
    
