#!/usr/bin/env bash

if [[ ! -f lm/ngram/2gram.trie ]]; then
	echo "Downloading language model for ASR evaluation ..."
	wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/2gram.trie  -O lm/ngram/2gram.trie
	echo "Language model downloaded."
fi

./error_rate  -m TER NID  --lm lm/ngram/2gram.trie  --ref ref.txt  --hyp hyp.txt  DETAILS.txt | tee RESULTS.txt
