# RunningPace

## Build tools

This project uses [SwiftLint](https://github.com/realm/SwiftLint) via the [Mint](https://github.com/yonaskolb/Mint) package manager. After installing Mint, run SwiftLint by executing:

```sh
$ mint run swiftlint
```

## Testing on Linux with Docker

Install Docker and then run `./testLinuxOnDocker.sh`. It will pull [the latest swift image from Docker Hub](https://hub.docker.com/_/swift), mount the current directory at `/src`, and then run the tests from inside the container.
