#!/usr/bin/bash
TS_SRCDIR=/home/dmeden/work/git/trafficserver/doc
TS2_SRCDIR=/home/dmeden/work/git/trafficserver.papi/doc
TXNB_SRCDIR=/home/dmeden/work/git/txn_box/doc
TS_PUBDIR=${PUBDIR:-"ats"}
TS2_PUBDIR=${PUBDIR:-"ats_plugin_api"}
TXNB_PUBDIR=${PUBDIR:-"txn_box"}

if [ -z "${TS_SRCDIR}" ] ; then SRCDIR="$PWD"; fi

git pull

# TS
if cd ${TS_PUBDIR} ; then
  echo Copying from ${TS_SRCDIR}/docbuild/html
else
  echo Publish respository \'${TS_PUBDIR}\' not found.
  exit 1
fi



rm -rf *
cp -r ${TS_SRCDIR}/docbuild/html/* .
#cp -r ${TS_SRCDIR}/docbuild/html/.nojekyll ats/
cp -r ${TS_SRCDIR}/docbuild/html/.buildinfo .

# TXN BOX
echo back to main folder
cd ..

if cd ${TXNB_PUBDIR} ; then
  echo Copying from ${TXN_SRCDIR}/docbuild/html
else
  echo Publish respository \'${TXNB_PUBDIR}\' not found.
  exit 1
fi



rm -rf *
cp -r ${TXNB_SRCDIR}/docbuild/html/* .
#cp -r ${TS_SRCDIR}/docbuild/html/.nojekyll ats/
cp -r ${TXNB_SRCDIR}/docbuild/html/.buildinfo .

# ATS2
echo back to main folder
cd ..

if cd ${TS2_PUBDIR} ; then
  echo Copying from ${TS2_SRCDIR}/docbuild/html
else
  echo Publish respository \'${TS2_PUBDIR}\' not found.
  exit 1
fi



rm -rf *
cp -r ${TS2_SRCDIR}/docbuild/html/* .
#cp -r ${TS_SRCDIR}/docbuild/html/.nojekyll ats/
cp -r ${TS2_SRCDIR}/docbuild/html/.buildinfo .


rm -rf src
echo "" > .nojekyll
git add .nojekyll
git add *

echo back to main folder

cd ..
git add *
git commit --message "Update" && git push --force
