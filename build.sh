#!/bin/bash
rm -rf output
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ProgramName="$( basename "$PWD" )"
gitHash="$(git log --pretty=format:'%h' -n 1)"
mkdir output
mkdir output/build
mkdir output/app
mkdir output/app/windows
mkdir output/app/macosx
mkdir output/app/linux
processing-java --sketch="$DIR" --output="$DIR/output/build" --force --build
processing-java --sketch="$DIR" --output="$DIR/output/app/macosx" --force --platform=macosx --export
processing-java --sketch="$DIR" --output="$DIR/output/app/windows" --force --platform=windows --export 
processing-java --sketch="$DIR" --output="$DIR/output/app/linux" --force --platform=linux --export 
zip -r ${ProgramName}-app-release-${gitHash}.zip "$DIR/output/app/"
