include .env
export $(shell sed 's/=.*//' .env)

clean:
	rm -f $(CONTAINER_NAME)

fmt:
	gofmt -w .

dep:
	godep save

run: fmt dep 
	go run *.go

test: fmt
	#Ignore the vendor directory
	go test  `go list ./... | grep -v vendor`

docker-build: fmt clean dep test
	docker build -t $(IMAGE_NAME):$(TAG) .

docker-start-dev: docker-build
	docker-compose -f docker-compose.dev.yml up -d

docker-stop-dev:
	docker-compose -f docker-compose.dev.yml stop
	docker-compose -f docker-compose.dev.yml rm

docker-start-prod: docker-build
	docker-compose -f docker-compose.production.yml up -d

docker-stop-prod:
	docker-compose -f docker-compose.production.yml stop
	docker-compose -f docker-compose.production.yml rm

docker-hub-publish: docker-build
	docker push $(IMAGE_NAME):$(TAG)