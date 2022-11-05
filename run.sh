#!/usr/bin/env bash

##echo "Downloading language model for ASR evaluation ..."
#wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/ngram_word/2gram.trie        -O lm/ngram_word/2gram.trie
#wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/ngram_subword256/4gram.trie  -O lm/ngram_subword256/4gram.trie
#wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/ngram_subword256/6gram.trie  -O lm/ngram_subword256/6gram.trie
#wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/ngram_subword1024/4gram.trie -O lm/ngram_subword1024/4gram.trie
#wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/ngram_subword1024/6gram.trie -O lm/ngram_subword1024/6gram.trie
##echo "Language model downloaded."

ref=ref.txt
hyp=hyp.txt

lm=lm/ngram_subword256/6gram.trie
tokenizer=lm/tokenizer256/tokenizer.model

# word-token TER & mTER
./error_rate  -m TER  -t word  --ref $ref  --hyp $hyp  DETAILS0.txt | tee RESULTS0.txt

# subword-token NIER
./error_rate  -m TER NID  -t $tokenizer  --lm $lm  --ref $ref  --hyp $hyp  DETAILS1.txt | tee RESULTS1.txt

## run examples in paper
#./error_rate  -m TER  --ref data/paper/ref.txt  --hyp data/paper/hyp.txt  tmp.txt

