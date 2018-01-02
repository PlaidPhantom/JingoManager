SHELL=/bin/bash

.DEFAULT_GOAL := help

.PHONY: help configure run stop all css js

.SECONDEXPANSION:

# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

configure: ## set up environment
	yarn install

clean: ## clean build artifacts
	rm -f scripts/*.min.js scripts/*.min.js.map
	rm -f server/*.min.js server/*.min.js.map
	rm -f styles/*.css styles/*.css.map

run: all ## build site and start the application server
	node server/server.min.js 8080 & echo $$! > server.pid

stop: ## stop running server instance
	kill $$(cat *.pid) ; rm *.pid

all: css js ## compile/bundle all client resources

css: styles/site.css ## compile/bundle client CSS

js: scripts/site.min.js server/server.min.js ## compile/bundle client JS

# TODO why does --compress not do anything?
styles/%.css: styles/%.styl $$(shell $$(shell npm bin)/stylus --deps styles/%.styl)
	$$(npm bin)/stylus --include-css --sourcemap $(WATCH) --compress --out $@ $<

server/%.min.js: server/%.js
	$$(npm bin)/rollup --config rollup.server.js --sourcemap $(WATCH) --input $< --output.format cjs --output.file $@

scripts/%.min.js: scripts/%.js
	$$(npm bin)/rollup --config rollup.client.js --sourcemap $(WATCH) --input $< --output.format es --output.file $@
