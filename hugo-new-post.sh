#!/bin/sh

# If a command fails then the deploy stops
set -e

POSTNAME=$1
THISYEAR=$(date +'%Y')
TODAY=$(date +'%Y-%m-%d')

POSTPATH="${THISYEAR}/${TODAY}-${POSTNAME}"
IMGFOLDER="./static/img/${POSTPATH}/"
NEWPOST="posts/${POSTPATH}.md"

echo "[  ] Initialising..."
echo "THISYEAR = ${THISYEAR}"
echo "TODAY = ${TODAY}"
echo "POSTPATH = ${POSTPATH}"
echo "IMGFOLDER = ${IMGFOLDER}"
echo "NEWPOST = ${NEWPOST}"
echo

# Create static image folder
mkdir -p "${IMGFOLDER}"
echo "[OK] mkdir -p ${IMGFOLDER}"
echo

# Create hugo new post
hugo new "${NEWPOST}"
echo "[OK] hugo new ${NEWPOST}"
echo
