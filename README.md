# PoliNetwork Document Templates

Sistema di template LaTeX modulare per i documenti ufficiali di **PoliNetwork APS**.
Il layout e' pensato per documenti riutilizzabili e stampabili: pagina bianca,
titolo forte, gerarchia tipografica pulita e footer istituzionale discreto.

## Struttura del progetto

```text
polinetwork-document/
|-- prompt.md                      # Prompt canonico per generare LaTeX con AI
|-- core/                          # Stile e logica
|   |-- polinetwork.cls            # Classe documento principale
|   |-- polinetwork-colors.sty     # Palette colori del brand
|   `-- polinetwork-commands.sty   # Comandi custom
|-- templates/                     # Sorgenti base riutilizzabili
|   `-- base-document.tex          # Skeleton minimo compilabile
|-- fonts/                         # Font del brand
|-- assets/                        # Logo e asset grafici
|-- documents/                     # Documenti sorgente reali
|-- exported/                      # PDF esportati manualmente
|-- output/                        # PDF compilati localmente
|-- Makefile
`-- README.md
```

Il template corrente usa uno sfondo bianco puro per garantire una buona resa in
stampa. `assets/site-background-soft.png` resta nel repository come asset legacy,
ma non viene applicato ai documenti.

## Prerequisiti

- **XeLaTeX**, incluso in TeX Live o MiKTeX.
- Pacchetti LaTeX: `fontspec`, `xcolor`, `geometry`, `fancyhdr`, `titlesec`,
  `hyperref`, `enumitem`, `tikz`, `microtype`, `parskip`, `setspace`,
  `booktabs`, `longtable`, `tabularx`, `array`, `lastpage`.

Su Arch Linux:

```bash
sudo pacman -S texlive-basic texlive-latex texlive-latexextra texlive-fontsrecommended texlive-xetex
```

Su Windows con MiKTeX puoi compilare senza `make`:

```powershell
$root = (Get-Location).Path
$env:TEXINPUTS = "$root\core;$root;"
New-Item -ItemType Directory -Force output | Out-Null
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output documents\PoliNetwork.tex
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output documents\PoliNetwork.tex
```

La doppia esecuzione aggiorna correttamente riferimenti e numero totale di pagine.

## Come compilare i documenti

Da Linux/macOS o da un ambiente Windows con `make` disponibile:

```bash
# Compila tutti i documenti
make all

# Compila solo "Cos'e' PoliNetwork"
make polinetwork

# Compila solo l'informativa privacy recruitment
make privacy-recruitment

# Pulisci i file di log temporanei
make clean
```

Tutti i PDF vengono creati nella cartella `output/`.

### Esportare in HTML

Serve [pandoc](https://pandoc.org) 3.0 o successivo (`brew install pandoc` /
`pacman -S pandoc`). Non serve LaTeX.

```bash
make html-privacy-policy-principale
```

Il comando crea `output/html/<nome>.html`: un unico file autocontenuto (circa
190 KB) con CSS, font e logo incorporati, da pubblicare così com'è. Non carica
nessuna risorsa esterna. I file di stile stanno in `core/html/`:

- `polinetwork.css`: font, palette e gerarchia dei titoli, ripresi dalla classe;
- `polinetwork.html`: template della pagina (header e footer);
- `fonts/*.woff2`: DM Sans e Poppins ridotti all'alfabeto latino, per tenere
  leggera la pagina. Generati da `fonts/*.ttf` con
  `pyftsubset <font>.ttf --unicodes='U+0000-024F,U+2000-206F,U+20AC,U+2122,U+2190-2193,U+2212' --layout-features='*' --flavor=woff2`
  (pacchetto `fonttools[woff]`);
- `logo.png`: logo ridimensionato a 128 px;
- `polinetwork-macros.tex`: traduce i comandi `\pn...` per pandoc. Se un
  documento usa un nuovo comando della classe, va aggiunto qui;
- `polinetwork.lua`: fa diventare `{\small ...}` un paragrafo `.small`.

La numerazione delle sezioni segue le opzioni `legal`/`report`/`numbered` della
classe e la lingua della pagina segue `\pnSetEnglish`. Gli elementi grafici in
TikZ (box, card, pill) non vengono convertiti.

## Workflow AI to LaTeX

Il file `prompt.md` e' il prompt canonico da dare a un'AI quando vuoi
trasformare testo libero in un documento LaTeX con questo stile.

Uso consigliato:

1. Fornisci all'AI il contenuto di `prompt.md`.
2. Aggiungi il testo da convertire.
3. Chiedi all'AI di restituire solo:
   - un blocco `latex` con il file `.tex` completo;
   - un blocco `bash` con il comando di compilazione.
4. Salva il sorgente dentro `documents/`.
5. Compila il file dalla root del progetto.

Il prompt vieta modifiche grafiche: l'AI deve usare la classe
`polinetwork`, i comandi pubblici del template e il contenuto ricevuto,
senza ridefinire colori, font, margini, header o footer.

## Come creare un nuovo documento

1. Parti da `templates/base-document.tex` oppure crea un file `.tex` dentro
   `documents/`, ad esempio `documents/nuovo-progetto.tex`.
2. Usa una delle classi disponibili:

```latex
\documentclass[letter]{polinetwork}
\documentclass[legal]{polinetwork}
\documentclass[report]{polinetwork}
```

3. Imposta almeno `\pnTitle{...}` nel preambolo.
4. Richiama `\pnMakeHeader` dopo `\begin{document}`.
5. Aggiungi il target al `Makefile` se vuoi compilarlo con `make`.

Per compilare direttamente un nuovo file senza aggiungere subito un target al
`Makefile`:

```bash
mkdir -p output
TEXINPUTS="$(pwd)/core:$(pwd):" xelatex -interaction=nonstopmode -halt-on-error -output-directory=output documents/nome-documento.tex
TEXINPUTS="$(pwd)/core:$(pwd):" xelatex -interaction=nonstopmode -halt-on-error -output-directory=output documents/nome-documento.tex
```

## Comandi disponibili

### Metadati documento

| Comando | Descrizione |
|---------|-------------|
| `\pnTitle{...}` | Titolo del documento |
| `\pnSubtitle{...}` | Sottotitolo opzionale |
| `\pnDocLabel{...}` | Etichetta breve sopra il titolo |
| `\pnDate{...}` | Data |
| `\pnProtocol{...}` | Numero protocollo |
| `\pnSubject{...}` | Oggetto |
| `\pnRecipient{...}` | Destinatario |
| `\pnVersion{...}` | Versione del documento |

### Layout

| Comando | Descrizione |
|---------|-------------|
| `\pnMakeHeader` | Intestazione stampabile con titolo grande, senza data/protocollo nel titolo |
| `\pnMakeMetadata` | Blocco metadati opzionale per data, versione, protocollo, destinatario e oggetto |
| `\pnMakeTitlePage` | Pagina di copertina per report |
| `\pnClosing` | Chiusura con spazio firma |
| `\pnContactBlock` | Blocco contatti finale senza separatori grafici |

Il footer automatico mostra il marchio compatto PoliNetwork, la mail
`direttivo@polinetwork.org` e la numerazione pagina. Il nome resta in Poppins
Medium blu, senza righe orizzontali.

### Sezioni e contenuto

| Comando | Descrizione |
|---------|-------------|
| `\section{...}` | Sezione standard consigliata |
| `\subsection{...}` | Sottosezione standard consigliata |
| `\pnSection{...}` | Sezione custom compatibile con documenti legacy |
| `\pnSubsection{...}` | Sottosezione custom compatibile |
| `\pnNumberedSection{...}` | Sezione numerata custom |
| `\pnArticle{...}` | Articolo numerato per documenti legali |
| `\pnClause{...}` | Comma/clausola dentro un articolo |

### Elementi grafici

| Comando | Descrizione |
|---------|-------------|
| `\pnHighlight{...}` | Testo evidenziato in blu |
| `\pnHighlightBox{...}` | Box informativo leggero |
| `\pnLead{...}` | Paragrafo introduttivo |
| `\pnInfoCard{...}{...}` | Card informativa |
| `\pnRule` | Spaziatore legacy senza riga visibile |
| `\pnWordmark` | Logo testuale "PoliNetwork" |

### Lingua

| Comando | Descrizione |
|---------|-------------|
| `\pnSetItalian` | Stringhe in italiano (default) |
| `\pnSetEnglish` | Stringhe in inglese |

## Opzioni della classe

```latex
\documentclass[letter]{polinetwork}     % Documenti comunicativi, senza numeri nei titoli
\documentclass[legal]{polinetwork}      % Documenti legali numerati
\documentclass[report]{polinetwork}     % Report con copertina e titoli numerati
\documentclass[numbered]{polinetwork}   % Forza titoli numerati
\documentclass[unnumbered]{polinetwork} % Forza titoli senza numeri
```

Per default il template privilegia la gerarchia visiva: colore, peso e
dimensione distinguono titolo, sezione e sottosezione. La numerazione e'
automatica solo per `legal` e `report`, dove serve citare sezioni e articoli.

## Palette colori

Il branding usa una palette basata su blue, sky, cyan e slate:

| Alias | Uso |
|-------|-----|
| `pn-primary` | Accent principale e link |
| `pn-accent` | Accent leggero |
| `pn-text` | Testo principale |
| `pn-text-secondary` | Testo secondario |
| `pn-text-muted` | Testo di servizio |
| `pn-background` | Colore legacy; il layout stampabile usa bianco puro |

## Font

| Font | Uso | Comando LaTeX |
|------|-----|---------------|
| **DM Sans** | Corpo testo, display | `\dmsansfont` |
| **Poppins** | Titoli, wordmark | `\poppinsfont` |
| **Red Hat Text** | Label, caption, footer | `\redhattextfont` |

## Licenza

(c) PoliNetwork APS - Tutti i diritti riservati.
