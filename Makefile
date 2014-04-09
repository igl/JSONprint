
# check windows 7
ifeq ($(OS), Windows_NT)
	SHELL=C:\Windows\SysWOW64\cmd.exe
endif

LSC         = "./node_modules/.bin/lsc"
LSC_FLAGS   = --compile --bare --output
MOCHA       = "./node_modules/.bin/mocha"
MOCHA_FLAGS = --colors --check-leaks --timeout 10000 --reporter spec --require expect.js --recursive

run: clean build test
	node release/

release: clean build test
	tar -cvzf printJSON.tgz release

build: clean
	mkdir "release/lib"
	mkdir "release/specs"
	${LSC} ${LSC_FLAGS} release source
	${LSC} ${LSC_FLAGS} specs specs


test: clean build
	${MOCHA} ${MOCHA_FLAGS} specs
	rm -rf specs/*.js


clean:
	rm -rf release
	rm -rf specs/*.js

.PHONY: release build test clean run
