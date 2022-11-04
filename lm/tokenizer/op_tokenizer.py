#!/usr/bin/env python3
# coding = utf8
#
# Copyright (c) 2021 Jiayu DU
# All rights reserved.

import sys, os, argparse
import sentencepiece as spm
from contextlib import contextmanager

@contextmanager
def open_stream(fname, mode):
    if fname == '-':
        if mode == 'r':
            yield sys.stdin
        elif mode == 'w+':
            yield sys.stdout
        else:
            raise NotImplementedError
    else:
        yield open(fname, mode, encoding='utf8')


def tokenizer_apply(mode, model_path, token, input_path, output_path):
    model = spm.SentencePieceProcessor()
    model.load(model_path)
    with open_stream(input_path, 'r') as istream, open_stream(output_path, 'w+') as ostream:
        if mode == 'encode':
            for l in istream:
                if token == 'piece':
                    pieces = model.EncodeAsPieces(l.strip())
                    encoded = ' '.join(pieces)
                elif token == 'id':
                    ids = model.EncodeAsIds(l.strip())
                    encoded = ' '.join([ str(x) for x in ids ])
                else:
                    raise NotImplementedError
                print(encoded, file = ostream)
        elif mode == 'decode':
            for l in istream:
                if token == 'piece':
                    pieces = l.strip().split()
                    decoded = sp.DecodePieces(pieces)
                elif token == 'id':
                    ids = [ int(x) for x in l.strip().split() ]
                    decoded = sp.DecodeIds(ids)
                else:
                    raise NotImplementedError
                print(decoded, file = ostream)
        else:
            raise NotImplementedError


if __name__ == '__main__':
    DESCRIPTION = '''
    e.g:
        cat i.txt | ops/tokenizer -m tokenizer.model > o.txt
        ops/tokenizer -m tokenizer.model -i i.txt -o o.txt
    '''
    parser = argparse.ArgumentParser(description = DESCRIPTION, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-n', '--num_workers', type = int, default = 1)
    parser.add_argument('-x', '--mode', choices=['encode', 'decode'], default = 'encode')
    parser.add_argument('-m', '--model', type = str, required = True)
    parser.add_argument('-t', '--token', choices=['piece', 'id'], default = 'piece')
    parser.add_argument('-i', '--input', type = str, default = '-')
    parser.add_argument('-o', '--output', type = str, default = '-')
    args = parser.parse_args()
    print(args, file = sys.stderr)

    if args.num_workers == 1:
        tokenizer_apply(args.mode, args.model, args.token, args.input, args.output)

    else:
        import glob

        assert(args.input != '-')
        assert(args.output != '-')

        wdir = args.output + '.dir'
        os.makedirs(wdir, exist_ok = True)

        print(f'Partitioning {args.input} into {wdir} ...', file = sys.stderr)
        os.system(f'split -n l/{args.num_workers} {args.input} {os.path.join(wdir, "part.")}')

        print('Generating commands ...', file = sys.stderr)
        cmds = os.path.join(wdir, 'cmds.sh')
        with open(cmds, 'w+') as f:
            for x in glob.glob(os.path.join(wdir, 'part.*')):
                y = os.path.join(wdir, os.path.basename(x).replace('part', 'out'))
                z = os.path.join(wdir, os.path.basename(x).replace('part', 'log'))
                print(f'ops/tokenizer -x {args.mode} -m {args.model} -t {args.token} -i {x} -o {y} >& {z}', file = f)

        print('Tokenizing all parts ...', file = sys.stderr)
        os.system(f'ops/run_para -n {args.num_workers} {cmds}')

        print('Merging results ...', file = sys.stderr)
        os.system(f'cat {os.path.join(wdir, "out.*")} > {args.output}')
