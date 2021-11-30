//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarSetup: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["FRONTWING"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REARWING"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ONTHROTTLE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["OFFTHROTTLE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FRONTCAMBER"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["REARCAMBER"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FRONTTOE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["REARTOE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FRONTSUSPENSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REARSUSPENSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FRONTANTIROLLBAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REARANTIROLLBAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FRONTSUSPENSIONHEIGHT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REARSUSPENSIONHEIGHT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BRAKEPRESSURE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BRAKEBIAS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REARLEFTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["REARRIGHTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FRONTLEFTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FRONTRIGHTTYREPRESSURE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["BALLAST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FUELLOAD"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}
