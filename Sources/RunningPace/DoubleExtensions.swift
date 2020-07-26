import Foundation

public extension Double {

    // MARK: Distance

    var feet: Distance {
        return Distance(value: self, unit: .feet)
    }

    var yards: Distance {
        return Distance(value: self, unit: .yards)
    }

    var miles: Distance {
        return Distance(value: self, unit: .miles)
    }

    var meters: Distance {
        return Distance(value: self, unit: .meters)
    }

    var kilometers: Distance {
        return Distance(value: self, unit: .kilometers)
    }

    // MARK: Duration

    var seconds: Duration {
        return Duration(value: self, unit: .seconds)
    }

    var minutes: Duration {
        return Duration(value: self, unit: .minutes)
    }

    var hours: Duration {
        return Duration(value: self, unit: .hours)
    }

    // MARK: Speed

    var minutesPerMile: Speed {
        return Speed(value: self, unit: .minutesPerMile)
    }

    var minutesPerKilometer: Speed {
        return Speed(value: self, unit: .minutesPerKilometer)
    }

    var milesPerHour: Speed {
        return Speed(value: self, unit: .milesPerHour)
    }

    var kilometersPerHour: Speed {
        return Speed(value: self, unit: .kilometersPerHour)
    }
}
