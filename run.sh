./error_rate  -m TER  --ref data/ref.txt  --hyp data/hyp.txt  DETAILS_TER.txt | tee RESULTS_TER.txt
./error_rate  -m NID  --ref data/ref.txt  --hyp data/hyp.txt  DETAILS_NID.txt | tee RESULTS_NID.txt

