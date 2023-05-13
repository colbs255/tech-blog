build:
	npx antora playbook.yaml
run: build
	open build/site/index.html
bootstrap:
	npm i -D -E @antora/cli@3.1 @antora/site-generator@3.1
clean:
	-rm -rf build

.PHONY: bootstrap run clean
