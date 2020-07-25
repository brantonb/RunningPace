import Foundation

public extension Measurement {
    static func / (distance: Distance, duration: Duration) -> Speed {
        let numeratorUnitLength: UnitLength
        let denominatorUnitDuration: UnitDuration
        let unitSpeed: UnitSpeed

        switch distance.unit {
        case .miles, .yards, .feet:
            numeratorUnitLength = .miles
            denominatorUnitDuration = .hours
            unitSpeed = .milesPerHour
        case .kilometers, .meters:
            numeratorUnitLength = .kilometers
            denominatorUnitDuration = .hours
            unitSpeed = .kilometersPerHour
        case .nauticalMiles:
            numeratorUnitLength = .nauticalMiles
            denominatorUnitDuration = .hours
            unitSpeed = .knots
        default:
            numeratorUnitLength = .meters
            denominatorUnitDuration = .seconds
            unitSpeed = .metersPerSecond
        }

        let distanceValue = distance.converted(to: numeratorUnitLength).value
        let durationValue = duration.converted(to: denominatorUnitDuration).value
        return Speed(value: distanceValue / durationValue, unit: unitSpeed)
    }

    static func / (duration: Duration, distance: Distance) -> Speed {
        let numeratorUnitDuration: UnitDuration = .minutes
        let denominatorUnitLength: UnitLength
        let unitSpeed: UnitSpeed

        switch distance.unit {
        case .miles, .yards, .feet:
            denominatorUnitLength = .miles
            unitSpeed = .minutesPerMile
        default:
            denominatorUnitLength = .kilometers
            unitSpeed = .minutesPerKilometer
        }

        let durationValue = duration.converted(to: numeratorUnitDuration).value
        let distanceValue = distance.converted(to: denominatorUnitLength).value
        return Speed(value: durationValue / distanceValue, unit: unitSpeed)
    }

    static func * (distance: Distance, speed: Speed) -> Duration {
        guard speed.value != 0 else {
            return Duration(value: Double.infinity, unit: .hours)
        }

        let minutes = distance.converted(to: .kilometers).value * speed.converted(to: .minutesPerKilometer).value
        let candidateUnits: [UnitDuration] = [.hours, .minutes, .seconds]
        let values = candidateUnits.map { Duration(value: minutes, unit: .minutes).converted(to: $0) }
        return values.first { abs($0.value) > 1 } ?? values.last!
    }

    static func * (speed: Speed, distance: Distance) -> Duration {
        return distance * speed
    }

    static func * (duration: Duration, speed: Speed) -> Distance {
        let unitLength: UnitLength
        switch speed.unit {
        case .minutesPerMile, .milesPerHour:
            unitLength = .miles
        case .metersPerSecond:
            unitLength = .meters
        case .knots:
            unitLength = .nauticalMiles
        case .minutesPerKilometer, .kilometersPerHour:
            unitLength = .kilometers
        default:
            unitLength = .kilometers
        }

        let kilometers = duration.converted(to: .minutes).value / speed.converted(to: .minutesPerKilometer).value
        return Distance(value: kilometers, unit: .kilometers).converted(to: unitLength)
    }

    static func * (speed: Speed, duration: Duration) -> Distance {
        return duration * speed
    }
}
