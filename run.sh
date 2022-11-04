#!/usr/bin/env bash

if [[ ! -f lm/4gram.trie ]]; then
    echo "Downloading language model for ASR evaluation ..."
    #wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/2gram_word.trie -O lm/2gram_word.trie
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/4gram.trie -O lm/4gram.trie
    #wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/6gram.trie -O lm/6gram.trie
    echo "Language model downloaded."
fi


# word-token TER & mTER
./error_rate  -m TER  --ref ref.txt  --hyp hyp.txt  DETAILS0.txt | tee RESULTS0.txt

# subword-token NIER
./error_rate  -m TER NID  -t lm/tokenizer.model  --lm lm/4gram.trie  --ref ref.txt  --hyp hyp.txt  DETAILS1.txt | tee RESULTS1.txt

## run examples in paper
#./error_rate  -m TER  --ref data/paper/ref.txt  --hyp data/paper/hyp.txt  tmp.txt

