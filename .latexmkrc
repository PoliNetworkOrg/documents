# .latexmkrc
# Configurazione per Overleaf e compilazione automatica

$pdf_mode = 5; # 5 = usa xelatex (necessario per caricare font moderni)
$do_cd = 0;    # Impedisce a latexmk di entrare nelle sottocartelle
               # (così xelatex lavora sempre dalla root del progetto)

# Esportiamo la cartella core in modo che LaTeX trovi i file .cls e .sty 
# esattamente come facciamo nel nostro Makefile locale.
$ENV{'TEXINPUTS'} = './core:./' . ($ENV{'TEXINPUTS'} ? ':' . $ENV{'TEXINPUTS'} : '');
