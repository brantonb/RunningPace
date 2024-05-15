import XCTest
import RunningPace

final class OperatorsTests: XCTestCase {

    func testDividingLengthByDuration() {
        let speed = 12.miles / 2.hours
        assertEqualSpeeds(6.milesPerHour, speed)
    }

    func testDividingLengthByDurationHasProperUnits() {
        let conversions: [(unitLength: UnitLength, unitSpeed: UnitSpeed)] = [
            (.miles, .milesPerHour),
            (.yards, .milesPerHour),
            (.feet, .milesPerHour),

            (.kilometers, .kilometersPerHour),
            (.meters, .kilometersPerHour),

            (.nauticalMiles, .knots),

            (.furlongs, .metersPerSecond),
        ]

        for (unitLength, unitSpeed) in conversions {
            let speed = Measurement(value: 1, unit: unitLength) / 10.minutes
            XCTAssertEqual(unitSpeed, speed.unit)
        }
    }

    func testDividingDurationByLength() {
        let speed = 17.minutes / 2.miles
        assertEqualSpeeds((8.5).minutesPerMile, speed)
    }

    func testDividingDurationByLengthHasProperUnits() {
        let conversions: [(unitLength: UnitLength, unitSpeed: UnitSpeed)] = [
            (.miles, .minutesPerMile),
            (.yards, .minutesPerMile),
            (.feet, .minutesPerMile),

            (.kilometers, .minutesPerKilometer),
            (.meters, .minutesPerKilometer),

            (.furlongs, .minutesPerKilometer),
            (.nauticalMiles, .minutesPerKilometer),
        ]

        for (unitLength, unitSpeed) in conversions {
            let speed = 10.minutes / Measurement(value: 1, unit: unitLength)
            XCTAssertEqual(unitSpeed, speed.unit)
        }
    }

    func testMultiplyingSpeedByDuration() {
        let distance = 8.minutesPerMile * 20.minutes
        assertEqualDistances((2.5).miles, distance)
    }

    func testMultiplyingSpeedAndDurationAreCommuniative() {
        let speed = 7.minutesPerMile
        let duration = 45.minutes
        assertEqualDistances(speed * duration, duration * speed)
    }

    func testMultiplyingSpeedByDurationHasProperUnits() {
        let conversions: [(unitSpeed: UnitSpeed, unitLength: UnitLength)] = [
            (.minutesPerMile, .miles),
            (.milesPerHour, .miles),

            (.minutesPerKilometer, .kilometers),
            (.kilometersPerHour, .kilometers),

            (.knots, .nauticalMiles),
            (.metersPerSecond, .meters),
        ]

        for (unitSpeed, unitLength) in conversions {
            let distance = 20.minutes * Speed(value: 10, unit: unitSpeed)
            XCTAssertEqual(unitLength, distance.unit)
        }
    }

    func testMultiplyingSpeedByDistance() {
        let duration = 8.minutesPerMile * 3.miles
        assertEqualDurations(24.minutes, duration)
    }

    func testMultiplyingSpeedByDistanceAreCommuniative() {
        let speed = 8.minutesPerMile
        let distance = 3.miles
        assertEqualDurations(speed * distance, distance * speed)
    }

    func testUnitsMultiplyingSpeedByDistanceOverOneHour() {
        let mpmDuration = 9.minutesPerMile * 10.miles
        XCTAssertEqual(.hours, mpmDuration.unit)

        let mphDuration = 50.milesPerHour * 200.miles
        XCTAssertEqual(.hours, mphDuration.unit)

        let mpkmDuration = 6.minutesPerKilometer * 20.miles
        XCTAssertEqual(.hours, mpkmDuration.unit)
    }

    func testUnitsMultiplyingSpeedByDistanceUnderNegativeOneHour() {
        let mpmDuration = (-9).minutesPerMile * 10.miles
        XCTAssertEqual(.hours, mpmDuration.unit)

        let mphDuration = (-50).milesPerHour * 200.miles
        XCTAssertEqual(.hours, mphDuration.unit)

        let mpkmDuration = (-6).minutesPerKilometer * 20.miles
        XCTAssertEqual(.hours, mpkmDuration.unit)
    }

    func testUnitsMultiplyingSpeedByDistanceUnderOneHourOverOneMinute() {
        let mpmDuration = 9.minutesPerMile * 3.miles
        XCTAssertEqual(.minutes, mpmDuration.unit)

        let mphDuration = 50.milesPerHour * 5.miles
        XCTAssertEqual(.minutes, mphDuration.unit)

        let mpkmDuration = 6.minutesPerKilometer * 8.kilometers
        XCTAssertEqual(.minutes, mpkmDuration.unit)
    }

    func testUnitsMultiplyingSpeedByDistanceOverNegativeOneHourUnderNegativeOneMinute() {
        let mpmDuration = (-9).minutesPerMile * 3.miles
        XCTAssertEqual(.minutes, mpmDuration.unit)

        let mphDuration = (-50).milesPerHour * 5.miles
        XCTAssertEqual(.minutes, mphDuration.unit)

        let mpkmDuration = (-6).minutesPerKilometer * 8.kilometers
        XCTAssertEqual(.minutes, mpkmDuration.unit)
    }

    func testUnitsMultiplyingSpeedByDistanceUnderOneMinuteOverZeroMinutes() {
        let mpmDuration = 9.minutesPerMile * 100.meters
        XCTAssertEqual(.seconds, mpmDuration.unit)

        let mphDuration = 50.milesPerHour * 200.yards
        XCTAssertEqual(.seconds, mphDuration.unit)

        let mpkmDuration = 6.minutesPerKilometer * 20.feet
        XCTAssertEqual(.seconds, mpkmDuration.unit)
    }

    func testUnitsMultiplyingSpeedByDistanceOverNegativeOneMinuteUnderZeroMinutes() {
        let mpmDuration = (-9).minutesPerMile * 100.meters
        XCTAssertEqual(.seconds, mpmDuration.unit)

        let mphDuration = (-50).milesPerHour * 200.yards
        XCTAssertEqual(.seconds, mphDuration.unit)

        let mpkmDuration = (-6).minutesPerKilometer * 20.feet
        XCTAssertEqual(.seconds, mpkmDuration.unit)
    }

    func testUnitsMultiplyingSpeedByDistanceEqualToZero() {
        let mpmDuration = 9.minutesPerMile * 0.meters
        XCTAssertEqual(.seconds, mpmDuration.unit)

        let mphDuration = 50.milesPerHour * 0.yards
        XCTAssertEqual(.seconds, mphDuration.unit)

        let mpkmDuration = 6.minutesPerKilometer * 0.feet
        XCTAssertEqual(.seconds, mpkmDuration.unit)
    }

    func testMultiplyingZeroSpeedByDistancesEqualToInfinityHours() {
        let mpmDuration = 0.minutesPerMile * 100.meters
        XCTAssertEqual(.infinity, mpmDuration.value)
        XCTAssertEqual(.hours, mpmDuration.unit)

        let mphDuration = 0.milesPerHour * 200.yards
        XCTAssertEqual(.infinity, mphDuration.value)
        XCTAssertEqual(.hours, mphDuration.unit)

        let mpkmDuration = 0.minutesPerKilometer * 20.feet
        XCTAssertEqual(.infinity, mpkmDuration.value)
        XCTAssertEqual(.hours, mpkmDuration.unit)
    }
}

private func assertEqualSpeeds(_ expected: Speed, _ actual: Speed) {
    let expectedMetersPerSecond = expected.converted(to: .metersPerSecond).value
    let actualMetersPerSecond = actual.converted(to: .metersPerSecond).value
    XCTAssertEqual(expectedMetersPerSecond, actualMetersPerSecond, accuracy: 0.00001)
}

private func assertEqualDistances(_ expected: Distance, _ actual: Distance) {
  #if os(Linux)
    let tolerance = 0.01
  #else
    let tolerance = 0.00001
  #endif
    let expectedMeters = expected.converted(to: .meters).value
    let actualMeters = actual.converted(to: .meters).value
    XCTAssertEqual(expectedMeters, actualMeters, accuracy: tolerance)
}

private func assertEqualDurations(_ expected: Duration, _ actual: Duration) {
  #if os(Linux)
    let tolerance = 0.01
  #else
    let tolerance = 0.0001
  #endif
    let expectedSeconds = expected.converted(to: .seconds).value
    let actualSeconds = actual.converted(to: .seconds).value
    XCTAssertEqual(expectedSeconds, actualSeconds, accuracy: tolerance)
}
}
