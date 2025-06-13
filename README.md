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
helm install word-emitter ./charts/word-emitter -n spark-streaming --create-namespace
```

### Connect from Spark

In your Spark Structured Streaming job:

```python
df = spark.readStream.format("socket").option("host", "word-emitter.spark-streaming.svc.cluster.local").option("port", 9999).load()
```
