# PoliNetwork Document Templates

Sistema di template LaTeX modulare per i documenti ufficiali di **PoliNetwork APS**.

Ispirato alla struttura di [Awesome-CV](https://github.com/posquit0/Awesome-CV), con il design coerente al nuovo branding dell'associazione.

## Struttura del progetto

```
polinetwork-document/
├── core/                          # Stile e logica (non modificare)
│   ├── polinetwork.cls            # Classe documento principale
│   ├── polinetwork-colors.sty     # Palette colori del brand
│   └── polinetwork-commands.sty   # Comandi custom (header, firma, ecc.)
├── fonts/                         # Font del brand
│   ├── DMSans-Variable.ttf        # DM Sans (corpo testo)
│   ├── Poppins-Medium.ttf         # Poppins (titoli, wordmark)
│   └── RedHatText-Variable.ttf    # Red Hat Text (label, didascalie)
├── assets/                        # Logo e elementi grafici
│   ├── Logo.png / Logo.svg        # Logo PoliNetwork
│   └── *.svg                      # Elementi decorativi
├── documents/                     # Documenti sorgente
│   ├── about/
│   ├── privacy-policy-recruitment/
│   └── ...
├── output/                        # PDF compilati (generata da make)
├── Makefile                       # Compilazione automatica
└── README.md
```

## Prerequisiti

- **XeLaTeX** (parte di [TeX Live](https://www.tug.org/texlive/))
- Pacchetti: `fontspec`, `xcolor`, `geometry`, `fancyhdr`, `titlesec`, `hyperref`, `enumitem`, `tikz`, `microtype`, `parskip`, `setspace`, `booktabs`, `longtable`, `lastpage`

Su Arch Linux:
```bash
sudo pacman -S texlive-basic texlive-latex texlive-latexextra texlive-fontsrecommended texlive-xetex
```

## Come compilare i documenti

Per garantire che LaTeX trovi tutti i font e i colori, sconsigliamo di lanciare `xelatex` a mano nelle singole cartelle. Invece, usa il sistema `make` dalla directory principale:

```bash
# Compila tutti i documenti
make all

# Compila solo "Cos'è PoliNetwork"
make about

# Pulisci i file di log temporanei
make clean
```

Tutti i PDF verranno creati comodamente all'interno della cartella `output/`.

### Come creare un nuovo tipo di documento

1. Crea una nuova cartella dentro `documents/` (es. `documents/nuovo-progetto`)
2. Crea il tuo file `.tex` e usa `\documentclass[legal]{polinetwork}`
3. Aggiungi il nuovo documento al `Makefile` seguendo gli esempi già presenti
4. Esegui `make [nuovo-documento]` dalla root

### 3. Comandi disponibili

#### Metadati documento

| Comando | Descrizione |
|---------|-------------|
| `\pnTitle{...}` | Titolo del documento |
| `\pnSubtitle{...}` | Sottotitolo |
| `\pnDate{...}` | Data |
| `\pnProtocol{...}` | Numero protocollo |
| `\pnSubject{...}` | Oggetto |
| `\pnRecipient{...}` | Destinatario |
| `\pnVersion{...}` | Versione del documento |

#### Layout

| Comando | Descrizione |
|---------|-------------|
| `\pnMakeHeader` | Header istituzionale (logo + contatti) |
| `\pnMakeMetadata` | Blocco metadati (data, protocollo, oggetto) |
| `\pnMakeTitlePage` | Pagina di copertina (per report) |
| `\pnClosing` | Chiusura con spazio firma |
| `\pnContactBlock` | Footer con contatti |

#### Sezioni stilizzate

| Comando | Descrizione |
|---------|-------------|
| `\pnSection{...}` | Sezione con accent bar blu |
| `\pnSubsection{...}` | Sotto-sezione |
| `\pnNumberedSection{...}` | Sezione numerata (per privacy policy, ecc.) |
| `\pnArticle{...}` | Articolo numerato (per documenti legali) |
| `\pnClause{...}` | Comma/clausola dentro un articolo |

#### Elementi grafici

| Comando | Descrizione |
|---------|-------------|
| `\pnHighlight{...}` | Testo evidenziato in blu |
| `\pnHighlightBox{...}` | Box informativo azzurro |
| `\pnRule` | Riga orizzontale decorativa |
| `\pnWordmark` | Logo testuale "PoliNetwork" |

#### Lingua

| Comando | Descrizione |
|---------|-------------|
| `\pnSetItalian` | Stringhe in italiano (default) |
| `\pnSetEnglish` | Stringhe in inglese |

### 4. Opzioni della classe

```latex
\documentclass[legal]{polinetwork}   % Documenti legali numerati
\documentclass[letter]{polinetwork}  % Lettere / Layout semplice
\documentclass[report]{polinetwork}  % Include copertina frontale
```

## Palette colori

Il branding usa palette Tailwind (cyan, sky, blue, slate):

| Alias | Colore | Uso |
|-------|--------|-----|
| `pn-primary` | Sky 700 `#0369A1` | Accent principale |
| `pn-accent` | Sky 300 `#7DD3FC` | Accent leggero |
| `pn-text` | Slate 900 `#0F172A` | Testo principale |
| `pn-text-secondary` | Slate 600 `#475569` | Testo secondario |
| `pn-background` | Slate 50 `#F8FAFC` | Sfondo |

## Font

| Font | Uso | Comando LaTeX |
|------|-----|---------------|
| **DM Sans** | Corpo testo, display | `\dmsansfont` |
| **Poppins** | Titoli, wordmark | `\poppinsfont` |
| **Red Hat Text** | Label, caption | `\redhattextfont` |

## Licenza

© PoliNetwork APS — Tutti i diritti riservati.
