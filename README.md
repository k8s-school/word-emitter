# Word Emitter for Spark Streaming

This project contains a simple Go-based TCP word emitter intended for use with Spark Structured Streaming.

## Components

- `go/`: Golang application that sends timestamped words via TCP
- `charts/word-emitter`: Helm chart to deploy the emitter in Kubernetes

## Usage

### Build & Push Docker Image

```bash
docker build -t your-dockerhub/word-emitter:latest ./go
docker push your-dockerhub/word-emitter:latest
```

### Deploy to Kubernetes

```bash
helm install word-emitter ./charts/word-emitter -n spark-streaming
```

### Connect from Spark

In your Spark Structured Streaming job:

```python
df = spark.readStream.format("socket").option("host", "netcat.spark-streaming.svc.cluster.local").option("port", 9999).load()
```
