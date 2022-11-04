#!/usr/bin/env bash

tn.py

cd tokenizer
sh train_tokenizer.sh
cd -

python tokenizer/op_tokenizer.py -x encode -m tokenizer/tokenizer.model -i text.txt -o tokenized.text.txt

cd ngram
sh train_ngram.sh
cd -

