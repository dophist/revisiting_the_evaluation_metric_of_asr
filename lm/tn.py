import string

puncts_to_remove = string.punctuation.replace("'", '')
puncts_trans = str.maketrans(puncts_to_remove, ' ' * len(puncts_to_remove), '')

with open('text.txt', 'r') as fi, open('text.txt.tn', 'w+') as fo:
    for line in fi:
        line = line.strip()
        if not line:
            continue

        if line.startswith('='): # titles '= Valkyria Chronicles III =' '= = Gameplay = ='
            continue

        sentences = line.split(' . ')
        for s in sentences:
            s = s.translate(puncts_trans)
            s = s.replace(" 's", "'s")
            s = ' '.join(s.split())
            s = s.upper()
            s = s.strip()
            if s:
                fo.write(s + '\n')


