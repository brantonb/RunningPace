import Foundation

public extension UnitSpeed {
    static let minutesPerMile = UnitSpeed(symbol: "\(UnitDuration.minutes.symbol)/\(UnitLength.miles.symbol)",
                                          converter: UnitConverterInverse(constant: 26.8224))

    static let minutesPerKilometer = UnitSpeed(symbol: "\(UnitDuration.minutes.symbol)/\(UnitLength.kilometers.symbol)",
                                               converter: UnitConverterInverse(constant: 16.666666666667))
}

class UnitConverterInverse: UnitConverter {
    let constant: Double

    init(constant: Double) {
        self.constant = constant
    }

    override func baseUnitValue(fromValue value: Double) -> Double {
        return constant / value
    }

    override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
        return constant / baseUnitValue
    }
}
