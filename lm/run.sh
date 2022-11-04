#!/usr/bin/env bash

sh download_text.sh

tn.py

python ops/tokenizer_train.py -c tokenizer.yaml -i text.txt.tn -o tokenizer
python ops/tokenizer.py -x encode -m tokenizer.model -i text.txt.tn -o text.txt.tn.tokenize

sh train_ngram.sh

