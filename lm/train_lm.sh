# To install KenLM training tool, follow https://github.com/kpu/kenlm

text=text.txt
arpa=2gram.arpa
trie=2gram.trie

# Train ARPA
cat $text | lmplz -o 2 > $arpa

# Convert ARPA to binary trie, with 8bit-foward 8bit-backoff quantization
build_binary -q 8 -b 8 trie $arpa $trie
