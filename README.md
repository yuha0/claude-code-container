# claude-code-container

claude-code container image

## Use the container image

`docker` or [apple/container](https://github.com/apple/container) have been tested:

```shell
container run --rm -u=$(id -u):$(id -g) --env TERM=$TERM -it -v $(pwd):/workspace -v ~/.claude:/claude ghcr.io/yuha0/claude-code-container:latest
```

And you can add it as a fish function:

```shell
function claudec
    container run --rm -u=(id -u):(id -g) -it --env TERM=$TERM -v (pwd):/workspace -v ~/.claude:/claude ghcr.io/yuha0/claude-code-container:latest $argv
end
```
