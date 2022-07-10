# Customize config file

```shell

# Make working directory if not exists
mkdir icecast

# Go to working directory
cd icecast

# Copy config file template from Docker image
docker run --rm -ti kyzimaspb/icecast cat /etc/icecast.tmpl > icecast.tmpl

# Edit the config file template and run the container
docker run --rm -ti \
  -v $(pwd)/icecast.tmpl:/etc/icecast.tmpl \
  -e ICECAST_ADMIN=admin@example.com \
  -e ICECAST_ADMIN_PASSWORD=123 \
  -e ICECAST_SOURCE_PASSWORD=123 \
  -e ICECAST_RELAY_PASSWORD=123 \
  kyzimaspb/icecast
```