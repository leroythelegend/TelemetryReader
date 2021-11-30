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
    
        self.data["SPEED"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["THROTTLE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["STEER"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["BRAKE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["CLUTCH"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GEAR"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["ENGINERPM"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["DRS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REVLIGHTSPERCENT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REVLIGHTSBITVALUE"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["BRAKESTEMPERATURE"] = try Decode<UInt>().decode2Bytes(amount: 4, from: &iter)
        self.data["TYRESSURFACETEMPERATURE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.data["TYRESINNERTEMPERATURE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.data["ENGINETEMPERATURE"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["TYRESPRESSURE"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["SURFACETYPE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
    }
}
