#./error_rate  -t char  -m TER  --ref data/ref.txt  --hyp data/hyp.txt  DETAILS_CER.txt | tee RESULTS_CER.txt
./error_rate  -m TER  --ref data/ref.txt  --hyp data/hyp.txt  DETAILS_WER.txt | tee RESULTS_WER.txt
./error_rate  -m NID  --ref data/ref.txt  --hyp data/hyp.txt  DETAILS_NID.txt | tee RESULTS_NID.txt
