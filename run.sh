#!/usr/bin/env bash

tokenizer=tokenizer_10k.model
wordcount=wordcount.tsv
if [[ ! -f assets/$tokenizer ]]; then
	mkdir -p assets
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/$tokenizer  -O assets/$tokenizer
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/$wordcount  -O assets/$wordcount
fi

ref=data/gigaspeech/ref.txt
hyp=data/gigaspeech/hyp.txt

# TER/mTER & NIER
#./error_rate  -m TER NID NIER -t word  --codec count:assets/$wordcount  --ref ref.txt  --hyp hyp.txt  DETAILS0.txt | tee RESULTS0.txt
./error_rate  -m TER NID NIER -t word                                   --ref $ref  --hyp $hyp  DETAILS1.txt | tee RESULTS1.txt
./error_rate  -m TER NID NIER -t word  --codec count:assets/$wordcount  --ref $ref  --hyp $hyp  DETAILS2.txt | tee RESULTS2.txt

## run examples in paper
#./error_rate  -m TER  -t word --ref data/paper/ref.txt  --hyp data/paper/hyp.txt  tmp.txt
