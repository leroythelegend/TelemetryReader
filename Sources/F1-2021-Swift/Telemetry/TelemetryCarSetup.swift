//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarSetup: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["FRONTWING"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REARWING"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ONTHROTTLE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["OFFTHROTTLE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["FRONTCAMBER"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["REARCAMBER"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["FRONTTOE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["REARTOE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["FRONTSUSPENSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REARSUSPENSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["FRONTANTIROLLBAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REARANTIROLLBAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["FRONTSUSPENSIONHEIGHT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REARSUSPENSIONHEIGHT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BRAKEPRESSURE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BRAKEBIAS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REARLEFTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["REARRIGHTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["FRONTLEFTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["FRONTRIGHTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["BALLAST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["FUELLOAD"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}
