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
├── documents/                     # Template documenti (usa questi!)
│   ├── privacy-policy/
│   ├── terms-and-conditions/
│   └── legal/
├── examples/                      # Esempi compilati
│   └── example-privacy-policy.tex
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

## Come usare

### 1. Compilare un esempio

```bash
cd examples
xelatex example-privacy-policy.tex
xelatex example-privacy-policy.tex   # seconda passata per riferimenti
```

Oppure dalla root:
```bash
make example-privacy
```

### 2. Creare un nuovo documento

1. Copia un template da `documents/` nella posizione desiderata
2. Modifica i campi nel preambolo (`\pnTitle`, `\pnDate`, ecc.)
3. Incolla/scrivi il contenuto nel body
4. Compila con `xelatex`

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
\documentclass[legal]{core/polinetwork}   % Documenti legali
\documentclass[letter]{core/polinetwork}  % Lettere
\documentclass[report]{core/polinetwork}  % Report con copertina
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
