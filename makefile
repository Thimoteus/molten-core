default: all

SRC = src/core.ls
BUILD ?= build
LSC ?= node_modules/.bin/lsc
LS ?= node_modules/LiveScript
MOCHA = node_modules/.bin/mocha
MOCHA2 = node_modules/.bin/_mocha
ISTANBUL = node_modules/.bin/istanbul

#BROWSERIFY = node_modules/.bin/browserify
#UGLIFYJS = node_modules/.bin/uglifyjs

build: $(SRC)
	@mkdir -p $(BUILD)
	@echo "Compiling source into directory $(BUILD) ..."
	@$(LSC) -c -o $(BUILD) $^

clean:
	@rm -rf $(BUILD)
	@rm -rf coverage

test: build
	@echo "Running tests ..."
	@$(MOCHA) --compilers ls:$(LS) --reporter spec

coverage:
	@echo "Building coverage report ..."
	@$(ISTANBUL) cover $(MOCHA2) -- --reporter spec --compilers ls:$(LS)

all: build

.PHONY: build clean all test coverage
