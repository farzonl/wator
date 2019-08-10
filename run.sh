#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -d "output" ]; then
  mkdir output
fi

if [ ! -d "output/build" ]; then
  mkdir output/build
fi

processing-java --sketch="$DIR" --output="$DIR/output/build" --force --run
