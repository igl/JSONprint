#
# check for windows
# we are using msys and gnu-make fails if not run in cmd.exe

ifeq ($(OS), Windows_NT)
	SHELL=C:\Windows\SysWOW64\cmd.exe
endif

LSC         = "./node_modules/.bin/lsc"
LSC_FLAGS   = --compile --bare --output
MOCHA       = "./node_modules/.bin/mocha"
MOCHA_FLAGS = --timeout 10000 --reporter spec --recursive --colors --check-leaks

default: build test

build: clean
	mkdir release
	${LSC} ${LSC_FLAGS} release source

test:
	${LSC} ${LSC_FLAGS} specs specs
	${MOCHA} ${MOCHA_FLAGS} specs
# delete compiled test-source after successful run
# source stays if test fails
	rm -rf specs/*.js

install:
	npm install
	make build

clean:
	rm -rf release
	rm -rf specs/*.js

.PHONY: default build test install clean
