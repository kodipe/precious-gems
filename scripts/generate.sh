#!/bin/sh

find content -type f -exec sh -c 'mv "$0" "${0%.*}.html"' {} \;
