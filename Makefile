SHELL=/bin/bash

.DEFAULT_GOAL := help

.PHONY: help configure clean debug run stop build build-client build-server

.SECONDEXPANSION:

# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

configure: ## set up environment
	yarn install

clean: ## clean build artifacts
	rm -Rf dist/
	rm -f server/*.min.js
	rm -f server/*.dbg.js
	rm -f server/*.js.map

debug: server/server.dbg.js ## build and start the debug app & API servers
	$$(npm bin)/parcel serve views/index.html -p 8080 & echo $$! > client.pid
	$$(npm bin)/nodemon server/server.dbg.js 8081 & echo $$! > api.pid
	$$(npm bin)/rollup --watch -c rollup.server.js -m --environment BUILD:development -f cjs -i server/server.js -o server/server.dbg.js 2>&1 & echo $$! > watch.pid

test:
	$$(npm bin)/rollup --watch -c rollup.server.js -m --environment BUILD:development -f cjs -i server/server.js -o server/server.dbg.js 2>&1

run: build ## build and run the production server
	node server/server.min.js 8080 & echo $$! > server.pid

stop: ## stop running server instances
	kill $$(cat *.pid) ; rm *.pid

build: build-client build-server #build production server

build-client:  ## build app for production
	$$(npm bin)/parcel build views/index.html --out-dir dist/ --public-url ./

build-server: server/server.min.js ## build server for production

server/%.min.js: server/%.js $$(shell nodejs deps.js server/%.js 2>/dev/null)
	$$(npm bin)/rollup -c rollup.server.js -m --environment BUILD:production -f cjs -i $< -o $@

server/%.dbg.js: server/%.js $$(shell nodejs deps.js server/%.js 2>/dev/null)
	$$(npm bin)/rollup -c rollup.server.js -m --environment BUILD:development -f cjs -i $< -o $@

# styles/%.css: styles/%.styl $$(shell $$(shell npm bin)/stylus --deps styles/%.styl)
# 	$$(npm bin)/stylus --include-css --sourcemap $(WATCH) --compress --out $@ $<
