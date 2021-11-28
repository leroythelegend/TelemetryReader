//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCar: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["SPEED"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["THROTTLE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["STEER"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["BRAKE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["CLUTCH"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["GEAR"] = try Decode<Int>().decodeByte(from: &iter)
        self.telemetry["ENGINERPM"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["DRS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REVLIGHTSPERCENT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REVLIGHTSBITVALUE"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["BRAKESTEMPERATURE"] = try Decode<UInt>().decode2Bytes(amount: 4, from: &iter)
        self.telemetry["TYRESSURFACETEMPERATURE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.telemetry["TYRESINNERTEMPERATURE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.telemetry["ENGINETEMPERATURE"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["TYRESPRESSURE"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.telemetry["SURFACETYPE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
    }
}
