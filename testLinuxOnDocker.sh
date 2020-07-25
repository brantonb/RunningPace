#!/bin/sh

docker run --rm --privileged --mount type=bind,source=$(pwd),target=/src --workdir /src swift:latest swift test --enable-test-discovery
