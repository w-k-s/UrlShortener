fmt:
	gofmt -w .

run: fmt
	go run *.go

start-local: fmt
	go build
	docker build -t short-url .
	docker run -d -p 27017:27017 -v ~/data:/data/db --name mongo mongo
	docker run -d -p 8080:8080 --link mongo:mongo --name short-url short-url

end-local:
	docker rm -f short-url
	docker rmi short-url
	docker rm -f mongo