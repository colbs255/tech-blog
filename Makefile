project_dir := $(shell pwd)
plantuml_url := https://github.com/plantuml/plantuml/releases/download/v1.2023.5/plantuml.jar
build:
	$(MAKE) build -C ui
	npx antora playbook.yaml
bootstrap:
	$(MAKE) bootstrap -C ui
	npm i -D -E @antora/cli@3.1 @antora/site-generator@3.1
clean:
	$(MAKE) clean -C ui
	-rm -rf build
diagrams: build/plantuml.jar
	mkdir -p modules/ROOT/images
	java -jar build/plantuml.jar -tsvg -Playout=smetana -theme bluegray "modules/ROOT/puml/*.puml" -o $(project_dir)/modules/ROOT/images
build/plantuml.jar:
	mkdir -p build
	curl -L $(plantuml_url) -o build/plantuml.jar

.PHONY: bootstrap run clean diagrams
