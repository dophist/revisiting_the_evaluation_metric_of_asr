#!/usr/bin/env python3
# Copyright (c) 2021 Jiayu DU
# All rights reserved.

import sys, os
import argparse
from omegaconf import OmegaConf # pip install omegaconf
import sentencepiece as spm     # pip install sentencepiece

def SentencePieceTrain(config, text, model_prefix):
    # https://colab.research.google.com/github/google/sentencepiece/blob/master/python/sentencepiece_python_module_example.ipynb
    if d := os.path.dirname(model_prefix):
        os.makedirs(d, exist_ok = True)

    config = OmegaConf.load(config)['sentencepiece']
    trainer_spec = (
        F' --input={text} '
        F' --model_prefix={model_prefix} '
        ' '.join([ F'--{k}={v}' for k,v in config.items() ])
    )
    spm.SentencePieceTrainer.Train(trainer_spec)
    '''
    To check vocab ~ id list:
      https://github.com/google/sentencepiece/issues/328
    >>> import sentencepiece as spm
    >>> sp = spm.SentencePieceProcessor()
    >>> sp.load('test_model.model')
    True
    >>> vocabs = [[sp.id_to_piece(id), id] for id in range(sp.get_piece_size())]
    >>> vocabs
    [['<unk>', 0], ['<s>', 1], ['</s>', 2], ['\r', 3], ['▁', 4], [',', 5], ...

    '''


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument('-c', '--config', type = str, required = True)
    parser.add_argument('-i', '--text', type = str, required = True, help='text, one sentence per line.')
    parser.add_argument('-o', '--model_prefix', type = str, required = True)

    args = parser.parse_args()
    print(args, file=sys.stderr)

    SentencePieceTrain(args.config, args.text, args.model_prefix)

