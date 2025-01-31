FROM golang:1.11.10-alpine3.9 as app

# Set some maintainer info
MAINTAINER Paulo Frazao <pfrazao@gmail.com>

# Install prerequisites into the image
RUN apk add -U build-base git
RUN apk add -U --no-cache curl

# Add files
COPY app /go/src/app
COPY app/static /static
COPY app/templates /templates

# Set the working directory
WORKDIR /go/src/app

# Set environment
ENV GO111MODULE=on
ENV COW_COLOR red

# Build the application
RUN go build -mod=vendor -a -v -tags 'netgo' -ldflags '-w -extldflags -static' -o docker-demo .

# Expose the port for the application
EXPOSE 80

# Set the entrypoint for the application
ENTRYPOINT ["/go/src/app/docker-demo"]
