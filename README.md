# Test Docker 

The container that obliges good development practices with Docker containers 

Support testing Dockerfiles (static code analysis), Images (unit tests), Containers (functional tests) - mostly using Ruby / RSpec plus Dockerlint





# Usage

To test this container using this container:

```
docker-compose up
```

To build
... have anothet compose file?

# How to reuse
Clone the repository

1. Update the Dockerfile to be your Dockerfile
1. Run docker-compose up, it will probably fail
1. Update the image_spec.rb this is your unit testing - don't add tests that need the container to be running
1. Update the container_spec.rb this is your runtime functional testing
 1. If your container does work and then stops, ...
 1. If your container runs as a daemon, ...






# Credits
A lot of inspiration came from here [http://www.unixdaemon.net/tools/testing-dockerfiles-with-serverspec/]
