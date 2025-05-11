.DEFAULT_GOAL := all

BUILD_DIR := build
DOCKER_EXEC_SCRIPT := ./scripts/docker_exec_command.sh
LATEX_CREATE_VARS_SCRIPT := ./scripts/create_vars_latex.sh
DOCKER_CONTAINTER := ml-student
SCALE_FACTOR_PERCENT := 55

NOTEBOOK := ../notebooks/A2_IU21_Kutsenko_2_3.ipynb
NOTEBOOK_BASENAME := $(shell basename $(basename $(NOTEBOOK)))
NOTEBOOK_FULL_PATH := $(realpath $(NOTEBOOK))

CONVERT_PATH := $(shell realpath ./src)

convert: $(NOTEBOOK_FULL_PATH)
	$(DOCKER_EXEC_SCRIPT) --container $(DOCKER_CONTAINTER) -cmd "jupyter nbconvert --to html --output-dir=$(CONVERT_PATH) $(NOTEBOOK_FULL_PATH)"
	echo "<script>document.body.style.zoom = \"$(SCALE_FACTOR_PERCENT)%\";</script>" >> $(CONVERT_PATH)/$(NOTEBOOK_BASENAME).html
	google-chrome --headless --disable-gpu --print-to-pdf-no-header --run-all-compositor-stages-before-draw --no-margins --print-to-pdf="$(CONVERT_PATH)/$(NOTEBOOK_BASENAME).pdf" "$(CONVERT_PATH)/$(NOTEBOOK_BASENAME).html"

build:
	mkdir -p $(BUILD_DIR)
	$(LATEX_CREATE_VARS_SCRIPT) --file $(CONVERT_PATH)/vars.tex --command "\newcommand{\notebookpdf}{\"src/$(NOTEBOOK_BASENAME).pdf\"}"
	pdflatex -synctex=1 -interaction=nonstopmode -output-directory=build *.tex
	pdflatex -synctex=1 -interaction=nonstopmode -output-directory=build *.tex
	cp $(BUILD_DIR)/main.pdf "$(NOTEBOOK_BASENAME).pdf"

clean:
	rm -rf $(shell pwd)/$(BUILD_DIR)

view: build/main.pdf
	evince build/main.pdf

all: convert build view

.PHONY: convert build
