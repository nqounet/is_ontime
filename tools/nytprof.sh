#!/bin/bash

perl -d:NYTProf myapp.pl
nytprofhtml
open nytprof/index.html
