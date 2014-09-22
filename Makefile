all: build

build:
	@docker build --tag=${USER}/redis .
