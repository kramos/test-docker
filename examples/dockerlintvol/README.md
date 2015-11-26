# Usage

From the root of the git repo run:
```
$ docker-compose -f examples/redis/docker-compose.yml up
```

# Notes

One interesting thing about this example is that the network of the test container is shared with the container under test (so that it can connect)

```
'HostConfig' => {
  'NetworkMode' => "container:" + ENV['CONTNAME'],
}
```

# Credit

Examples inspired based on [blog](http://www.unixdaemon.net/tools/testing-dockerfiles-with-serverspec/) by Dean Wilson at unixdaemon.net


