project_dir := $(shell pwd)
plantuml_url := https://github.com/plantuml/plantuml/releases/download/v1.2023.5/plantuml.jar
asciidoc_attributes := -a source-highlighter=highlight.js -a sectanchors -a sectlinks -a table-caption! -a stylesheet=../style/clean.css

build: build/index.html
build/plantuml.jar:
	mkdir -p build
	curl -L $(plantuml_url) -o build/plantuml.jar
build/index.html: build/plantuml.jar
	java -jar build/plantuml.jar "content/*.puml" build -tpng -Playout=smetana -o $(project_dir)/build
	asciidoctor -D build --backend=html5 $(asciidoc_attributes) content/*.adoc 
run: build/index.html
	open build/index.html
clean:
	-rm -rf build

.PHONY: clean build run
