text=lm/text.txt
arpa=lm/2gram.arpa
trie=lm/2gram.trie

# Train ARPA
cat $text | lmplz -o 2 > $arpa

# Convert ARPA to foward-8bit backoff-8bit quantized trie
build_binary -q 8 -b 8 trie $arpa $trie

