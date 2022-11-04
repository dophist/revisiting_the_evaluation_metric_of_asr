# To install KenLM training tool, follow https://github.com/kpu/kenlm
text=text.txt.tn.tokenize
order=4
arpa=${order}gram.arpa
trie=${order}gram.trie

# Train ARPA
cat $text | lmplz -o $order > $arpa

# Convert ARPA to binary trie, with 8bit-foward 8bit-backoff quantization
build_binary -q 8 -b 8 trie $arpa $trie

