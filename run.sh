#!/usr/bin/env bash

tokenizer=tokenizer_10k.model
if [[ ! -f assets/$tokenizer ]]; then
	mkdir -p assets
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/$tokenizer  -O assets/$tokenizer
fi

ref=ref.txt
hyp=hyp.txt
#ref=data/gigaspeech/ref.txt
#hyp=data/gigaspeech/hyp.txt

# TER/mTER & NID
./error_rate  -m TER NID  -t word  --ref $ref  --hyp $hyp  DETAILS.txt | tee RESULTS.txt

## run examples in paper
#./error_rate  -m TER  --ref data/paper/ref.txt  --hyp data/paper/hyp.txt  tmp.txt
