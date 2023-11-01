#!/bin/bash
set -e

name=qdox
version="$(sed -n 's/Version:\s*//p' *.spec)"
vertag="$(sed -n 's/%global\s*vertag\s*//p' *.spec)"

# RETRIEVE
wget "http://repo2.maven.org/maven2/com/thoughtworks/qdox/qdox/${version}-${vertag}/${name}-${version}-${vertag}-project.tar.gz" -O "${name}-${version}-${vertag}.orig.tar.gz"

rm -rf tarball-tmp
mkdir tarball-tmp
cd tarball-tmp
tar xf "../${name}-${version}-${vertag}.orig.tar.gz"

# CLEAN TARBALL
find -name '*.jar' -delete
find -name '*.class' -delete
# contains possibly proprietary binaries of YACC
rm -r */bootstrap

tar cf "../${name}-${version}-${vertag}.tar.gz" *
cd ..
rm -r tarball-tmp "${name}-${version}-${vertag}.orig.tar.gz"
