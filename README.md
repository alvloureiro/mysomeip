# My Someip sample

## vsomeip.json sample below

```json
{
  "unicast": "127.0.0.1",
  "logging": {
    "level": "debug"
  },
  "applications": {
      "hello_world_service": {
        "id": "0x1234"
      },
      "hello_world_client": {
        "id": "0x5678"
      }
  },
  "services": [
    {
      "service": "0x1234",
      "instance": "0x5678",
      "reliable": "30490",
      "unreliable": "30491"
    }
  ]
}
```

Replace 127.0.0.1 with the host machine's IP address or 0.0.0.0 to bind to all interfaces.

## Mount this file into the container and expose the required ports

```bash
docker run -it --network=host \
 -v $(pwd)/vsomeip.json:/vsomeip/examples/hello_world/build/vsomeip.json \
 vsomeip-hello-world
 ```

## Start the service in Docker

1. Export the configuration file

```bash
export VSOMEIP_CONFIGURATION=/vsomeip/examples/hello_world/build/vsomeip.json
```

2. Start the hello world service

```bash
./hello_world_service
```

## Run the client in another machine or outside Docker

To run the client on another machine or outside Docker:

1. Ensure the client has access to the same vsomeip.json file, and update the unicast IP address in the file to point to the machine running the service (the Docker host).

2. Set the ``VSOMEIP_CONFIGURATION`` variable:

```bash
export VSOMEIP_CONFIGURATION=/path/to/vsomeip.json
```

3. Run the client

```bash
./hello_world_client
```

## Enable Docker networking

If using Docker’s default bridge network, configure port mapping explicitly:

```bash
docker run -it -p 30490:30490/udp -p 30491:30491/tcp \
    -v $(pwd)/vsomeip.json:/vsomeip/examples/hello_world/build/vsomeip.json \
    vsomeip-hello-world
```
