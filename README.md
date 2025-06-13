# Word Emitter for Spark Streaming

This project contains a simple Go-based TCP word emitter intended for use with Spark Structured Streaming.

## Components

- `rootfs/app/`: Golang application that sends timestamped words via TCP
- `charts/word-emitter`: Helm chart to deploy the emitter in Kubernetes

## Usage

### Build & Push Docker Image

```bash
./build.sh
./push-image.sh
```

### Deploy to Kubernetes

```bash
helm install word-emitter ./charts/word-emitter -n word-emitter --create-namespace
```

### Connect from other pod

In an ubuntu pod:
```bash
kubectl run -i --rm --tty shell --image=ubuntu -- bash
apt update && apt install netcat-traditional
nc word-emitter.word-emitter 9999
```
