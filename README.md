# RunningPace

This package adds two new [`UnitSpeed`](https://developer.apple.com/documentation/foundation/unitspeed) types that distance runners often use for paces: `.minutesPerMile` and `.minutesPerKilometer`. It also adds multiplication and division operators for the basic "speed * time = distance" formula. Finally, it adds type aliases to make working with measurements easier and extensions to create measurements from `Double` values more readable.

## Usage

``` Swift
// Basic usage
let pace = Measurement<UnitSpeed>(value: 10, unit: .minutesPerMile)
print(pace) // "10.0 min/mile"

// Usage with type aliases
let kmPace = Speed(value: 6, unit: .minutesPerKilometer)
let duration = Duration(value: 30, unit: .minutes)
let distance = Distance(value: 1600, unit: .meters)

// Usage with Double extensions
let milePace = 10.minutesPerMile
let duration = 30.5.minutes
let distance = 5.miles

// Operators
let duration = 10.miles * 6.25.minutesPerMile
let distance = 51.minutes * 5.minutesPerKilometer
let speed = (17.minutes / 5.kilometers).converted(to: .minutesPerMile)
```

## Installation

### Swift Package Manager

This component is designed to be used with Swift Package Manager. Add the following to your `Package.swift` file's dependencies:

``` Swift
.package(url: "https://github.com/brantonb/RunningPace.git", from: "0.1.0")
```

And then add `import RunningPace` wherever needed.

## Contributing

Pull requests are welcome. Before submitting, please ensure that all tests pass and SwiftLint is clean.

### SwiftLint

This project uses [SwiftLint](https://github.com/realm/SwiftLint) via the [Mint](https://github.com/yonaskolb/Mint) package manager. After installing Mint, run SwiftLint by executing:

``` sh
$ mint run swiftlint
```

### Testing on Linux with Docker

Install Docker and then run `./testLinuxOnDocker.sh`. It will pull [the latest swift image from Docker Hub](https://hub.docker.com/_/swift), mount the current directory at `/src`, and then run the tests from inside the container.
