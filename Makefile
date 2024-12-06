.PHONY: clean
#clean build directory
clean:
	rm -rf build

.PHONY: cpp
# make cpp demo
cpp:
	cd demo && g++ main.cpp demo.h demo.c -o main &&./main

.PHONY: lib
# make demo lib
lib:
	cd demo && gcc --shared -o libdemo.so -fPIC demo.c

.PHONY: run
#run demo
run:
	CGO_CFLAGS="-I${PWD}/demo" CGO_LDFLAGS="-L${PWD}/demo -Wl,-rpath=${PWD}/demo" go run main.go
	
.PHONY: help
# show help
help:
	@echo ''
	@echo 'Usage:'
	@echo ' make [target]'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
	helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help