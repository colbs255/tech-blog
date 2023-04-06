build: build/index.html
build/plantuml.jar:
	mkdir -p build
	curl -L https://github.com/plantuml/plantuml/releases/download/v1.2023.5/plantuml.jar -o build/plantuml.jar
build/index.html: build/plantuml.jar
	java -jar build/plantuml.jar "content/*.puml" build -tpng -Playout=smetana -o /Users/colby/projects/tech-notes/build
	asciidoctor -D build --backend=html5 content/*.adoc
run: build/index.html
	open build/index.html
clean:
	-rm -rf build

.PHONY: clean build run
