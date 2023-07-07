all: bootstrap build
build:
	$(MAKE) build -C ui
	npx antora playbook.yaml
bootstrap:
	$(MAKE) bootstrap -C ui
	npm install
clean:
	$(MAKE) clean -C ui
	-rm -rf build

.PHONY: all bootstrap clean
