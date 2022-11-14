#!/usr/bin/env bash

if [[ ! -f lm/tokenizer.model ]]; then
    echo "Downloading language model for ASR evaluation ..."
    # sentencepiece tokenizer & lm
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/tokenizer256/tokenizer.model -O lm/tokenizer256.model
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/lm256/4gram.trie -O lm/256_4gram.trie

    cd lm
    ln -s tokenizer256.model tokenizer.model
    cd -

    # Huffman Codec word frequency
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/word_count.tsv -O codec/word_count.tsv
fi

lm=lm/256_4gram.trie
tokenizer=lm/tokenizer.model

ref=ref.txt
hyp=hyp.txt


# word-level TER/mTER
./error_rate  -m TER  -t word  --ref $ref  --hyp $hyp  DETAILS0.txt | tee RESULTS0.txt

## subword-level TER/mTER & NID
#./error_rate  -m TER NID  -t $tokenizer  --lm $lm  --ref $ref  --hyp $hyp  DETAILS1.txt | tee RESULTS1.txt

# subword-level TER/mTER & NID
./error_rate  -m TER NID  -t word  --codec codec/word_count.tsv  --ref $ref  --hyp $hyp  DETAILS2.txt | tee RESULTS2.txt

## run examples in paper
#./error_rate  -m TER  --ref data/paper/ref.txt  --hyp data/paper/hyp.txt  tmp.txt

