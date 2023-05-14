build:
	$(MAKE) build -C ui
	npx antora playbook.yaml
bootstrap:
	$(MAKE) bootstrap -C ui
	npm i -D -E @antora/cli@3.1 @antora/site-generator@3.1
clean:
	$(MAKE) clean -C ui
	-rm -rf build

.PHONY: bootstrap clean
