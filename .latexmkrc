# .latexmkrc
# Configurazione per Overleaf e compilazione automatica

$pdf_mode = 5; # 5 = usa xelatex (necessario per caricare font moderni)
$do_cd = 0;    # Impedisce a latexmk di entrare nelle sottocartelle
               # (così xelatex lavora sempre dalla root del progetto)

# Esportiamo la cartella core senza perdere i path standard di TeX Live.
# Il ":" finale dice a kpathsea di aggiungere anche i percorsi di default.
$ENV{'TEXINPUTS'} = './core:./:'
  . ($ENV{'TEXINPUTS'} ? $ENV{'TEXINPUTS'} : '');
