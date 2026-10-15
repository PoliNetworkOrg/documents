# =====================================================================
# Makefile — PoliNetwork Document Templates
# =====================================================================
#
# Prerequisiti: XeLaTeX (da TeX Live)
#   sudo apt install texlive-xetex texlive-fonts-recommended texlive-latex-extra
#
# Uso:
#   make help                 Mostra tutti i target disponibili
#   make privacy-recruitment  Compila la privacy policy del recruitment
#   make about                Compila il documento "Cos'è PoliNetwork"
#   make all                  Compila tutti i documenti
#   make html-<nome>          Esporta documents/<nome>.tex in HTML (richiede pandoc)
#   make clean                Pulisce i file ausiliari
#
# =====================================================================

XELATEX = xelatex
XELATEX_FLAGS = -interaction=nonstopmode -halt-on-error

# Root directory (per TEXINPUTS)
ROOT_DIR := $(shell pwd)
OUT_DIR := $(ROOT_DIR)/output

# TEXINPUTS permette a XeLaTeX di trovare i file .cls, .sty, font e assets
# ovunque si compili — è la "magia" che tiene tutto collegato
TEXINPUTS_VAL = $(ROOT_DIR)/core:$(ROOT_DIR):

# Macro per compilare un documento (2 passate per riferimenti corretti)
# Uso: $(call compile,<directory>,<filename senza .tex>)
define compile
	@mkdir -p $(OUT_DIR)
	TEXINPUTS="$(TEXINPUTS_VAL)" $(XELATEX) $(XELATEX_FLAGS) -output-directory="$(OUT_DIR)" $(1)/$(2).tex
	TEXINPUTS="$(TEXINPUTS_VAL)" $(XELATEX) $(XELATEX_FLAGS) -output-directory="$(OUT_DIR)" $(1)/$(2).tex
	@echo "✓ Generato: output/$(2).pdf"
endef

# --- Export HTML (pandoc >= 3.0) ---
# I comandi della classe sono tradotti da core/html/polinetwork-macros.tex,
# lo stile da core/html/polinetwork.css. Il risultato e' un unico file HTML
# autocontenuto: CSS, font (woff2 ridotti al solo alfabeto latino) e logo
# sono incorporati nella pagina.
PANDOC = pandoc
HTML_SRC := $(ROOT_DIR)/core/html
HTML_OUT := $(OUT_DIR)/html

# Numerazione delle sezioni come nel PDF: solo con le opzioni legal/report/numbered
html_numbered = $(shell grep -lE '^\\documentclass\[([^]]*,)? *(legal|report|numbered) *[],]' $(1))
html_lang = $(if $(shell grep -l '\\pnSetEnglish' $(1)),en,it)

# =====================================================================
# TARGET PRINCIPALI
# =====================================================================

.PHONY: all clean clean-pdf help html-%

help: ## Mostra questo aiuto
	@echo ""
	@echo "  PoliNetwork Document Templates — Build System"
	@echo "  =============================================="
	@echo ""
	@echo "  Documenti:"
	@echo "    make privacy-recruitment    Privacy policy recruitment"
	@echo "    make polinetwork            Cos'è PoliNetwork (versione pubblica)"
	@echo ""
	@echo "  Utility:"
	@echo "    make all                    Compila tutti i documenti"
	@echo "    make html-<nome>            Esporta documents/<nome>.tex in HTML (output/html/)"
	@echo "    make clean                  Pulisce file ausiliari (.aux, .log, ecc.)"
	@echo "    make clean-pdf              Pulisce anche i PDF generati"
	@echo ""
	@echo "  Prerequisiti (Arch Linux): sudo pacman -S texlive-basic texlive-latex texlive-latexextra texlive-fontsrecommended texlive-xetex"
	@echo ""

# =====================================================================
# DOCUMENTI
# =====================================================================

privacy-recruitment: ## Privacy policy per il recruitment
	$(call compile,documents,informativa-privacy-recruitment)

guida: # Guida della matricola
	$(call compile,documents,guida-della-matricola)

pubblica: polinetwork # alias
polinetwork: ## Cos'è PoliNetwork
	$(call compile,documents,PoliNetwork)

# --- Aggiungi qui nuovi documenti ---
# esempio:
# privacy-sito: ## Privacy policy del sito web
# 	$(call compile,documents,privacy-policy-sito)

all: privacy-recruitment polinetwork ## Compila tutti i documenti

html-%: documents/%.tex ## Esporta un documento in HTML (es. make html-privacy-policy-principale)
	@mkdir -p $(HTML_OUT)
	$(PANDOC) -f latex -t html5 --standalone --embed-resources \
		--resource-path=$(HTML_SRC) \
		--template=$(HTML_SRC)/polinetwork.html \
		--lua-filter=$(HTML_SRC)/polinetwork.lua \
		--shift-heading-level-by=1 \
		$(if $(call html_numbered,$<),--number-sections) \
		-M lang=$(call html_lang,$<) \
		$(HTML_SRC)/polinetwork-macros.tex $< -o $(HTML_OUT)/$*.html
	@echo "✓ Generato: output/html/$*.html"

# =====================================================================
# PULIZIA
# =====================================================================

clean: ## Rimuovi file ausiliari
	find . \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.toc' \
	       -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.synctex.gz' \) \
	       -delete 2>/dev/null || true
	@echo "✓ File ausiliari rimossi"

clean-pdf: clean ## Rimuovi anche i PDF generati
	rm -rf $(OUT_DIR)/*.pdf 2>/dev/null || true
	@echo "✓ PDF rimossi dalla cartella output"
