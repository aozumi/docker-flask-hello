# An Example to Deploy a Flask Application Using Docker

NOTE: Makefile is written for BSD make.  Use `bmake` in Linux systems.

## Build the application

```
make build-app
```

This builds a package of the application.

## Build Docker image

```
make build-docker
```

## Run

To create new container and run it:
```
make run
```

To run in foreground:
```
make run-foreground
```
