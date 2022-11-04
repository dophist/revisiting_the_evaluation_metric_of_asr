#!/usr/bin/env bash

if [[ ! -f lm/ngram/ngram.trie ]]; then
	echo "Downloading language model for ASR evaluation ..."
	wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/4gram.trie -O lm/4gram.trie
	echo "Language model downloaded."
fi

./error_rate  -m TER NID  --lm lm/4gram.trie  -t lm/tokenizer.model  --ref ref.txt  --hyp hyp.txt  DETAILS.txt | tee RESULTS.txt

## run examples in paper
#./error_rate  -m TER  --ref data/paper/ref.txt  --hyp data/paper/hyp.txt  tmp.txt
