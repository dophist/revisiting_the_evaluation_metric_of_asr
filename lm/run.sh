#!/usr/bin/env bash

# prepare text
ossutil64 cp  oss://swaphub/asr_metric_assets/wikitext-103/wiki.train.tokens   wiki.train.tokens
ossutil64 cp  oss://swaphub/asr_metric_assets/wikitext-103-raw/wiki.train.raw  wiki.train.raw
ln -s wiki.train.raw text.txt

# textnorm
tn.py

# train tokenizer and tokenize text
python ops/tokenizer_train.py -c tokenizer.yaml -i text.txt.tn -o tokenizer
python ops/tokenizer.py -x encode -m tokenizer.model -i text.txt.tn -o text.txt.tn.tokenize

# train subwords ngram model
sh train_ngram.sh

