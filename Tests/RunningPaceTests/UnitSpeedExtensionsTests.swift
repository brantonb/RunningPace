import XCTest
import RunningPace

final class RunningPaceTests: XCTestCase {

    // MARK: - MPH

    func test0MphisInfinityMinutesPerMile() {
        assertEqualSpeeds(Double.infinity.minutesPerMile, 0.milesPerHour)
    }

    func test10MphIs6MinutesPerMile() {
        assertEqualSpeeds(6.minutesPerMile, 10.milesPerHour)
    }

    func testNegativeMphIsNegativePace() {
        assertEqualSpeeds((-6).minutesPerMile, (-10).milesPerHour)
    }

    func testMinutesPerMileConvertsBack() {
        let original = (8.5).minutesPerMile
        let milesPerHour = original.converted(to: .milesPerHour)
        let final = milesPerHour.converted(to: .minutesPerMile)
        assertEqualSpeeds(original, final)
    }

    // MARK: - KPH

    func test0KphisInfinityMinutesPerKilometer() {
        assertEqualSpeeds(Double.infinity.minutesPerKilometer, 0.kilometersPerHour)
    }

    func test10KphIs6MinutePerKilometers() {
        assertEqualSpeeds(6.minutesPerKilometer, 10.kilometersPerHour)
    }

    func testNegativeKphIsNegativePace() {
        assertEqualSpeeds((-6).minutesPerKilometer, (-10).kilometersPerHour)
    }

    func testMinutesPerKilometerConvertsBack() {
        let original = (8.5).minutesPerMile
        let milesPerHour = original.converted(to: .milesPerHour)
        let final = milesPerHour.converted(to: .minutesPerMile)
        assertEqualSpeeds(original, final)
    }
}

private func assertEqualSpeeds(_ expected: Speed, _ actual: Speed, file: StaticString = #file, line: UInt = #line) {
    let tolerance = 0.00001
    let expectedMetersPerSecond = expected.converted(to: .metersPerSecond).value
    let actualMetersPerSecond = actual.converted(to: .metersPerSecond).value
    XCTAssertEqual(expectedMetersPerSecond, actualMetersPerSecond, accuracy: tolerance)
}
