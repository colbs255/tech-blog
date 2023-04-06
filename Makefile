project_dir := $(shell pwd)
plantuml_url := https://github.com/plantuml/plantuml/releases/download/v1.2023.5/plantuml.jar

build: build/index.html
build/plantuml.jar:
	mkdir -p build
	curl -L $(plantuml_url) -o build/plantuml.jar
build/index.html: build/plantuml.jar
	java -jar build/plantuml.jar "content/*.puml" build -tpng -Playout=smetana -o $(project_dir)/build
	asciidoctor -D build --backend=html5 content/*.adoc
run: build/index.html
	open build/index.html
clean:
	-rm -rf build

.PHONY: clean build run
