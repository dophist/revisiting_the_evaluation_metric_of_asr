#!/usr/bin/env bash

tokenizer=tokenizer_10k.model
if [[ ! -f assets/$tokenizer ]]; then
    echo "Downloading assets for ASR evaluation ..."
	mkdir -p assets
    wget  https://swaphub.oss-cn-hangzhou.aliyuncs.com/asr_metric_assets/$tokenizer  -O assets/$tokenizer
fi

ref=ref.txt
hyp=hyp.txt

# word-level TER/mTER
./error_rate  -m TER  -t word  --ref $ref  --hyp $hyp  DETAILS0.txt | tee RESULTS0.txt

# subword-level TER/mTER & NID
./error_rate  -m TER NID  -t assets/$tokenizer  --codec spm:assets/$tokenizer  --ref $ref  --hyp $hyp  DETAILS1.txt | tee RESULTS1.txt

## run examples in paper
#./error_rate  -m TER  --ref data/paper/ref.txt  --hyp data/paper/hyp.txt  tmp.txt

