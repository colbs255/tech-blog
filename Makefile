build:
	asciidoctor -D build --backend=html5 content/*.adoc
run: build
	open build/index.html
clean:
	rm -rf build

.PHONY: clean run
