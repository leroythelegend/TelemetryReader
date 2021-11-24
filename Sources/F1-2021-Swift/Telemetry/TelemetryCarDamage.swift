//
//  File.swift
//  
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarDamage: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["TYRESWEAR"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.telemetry["TYRESDAMAGE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.telemetry["BRAKESDAMAGE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.telemetry["FRONTLEFTWINGDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["FRONTRIGHTWINGDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["REARWINGDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["FLOORDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DIFFUSERDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SIDEPODDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DRSFAULT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["GEARBOXDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ENGINEDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ENGINEMGUHWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ENGINEESWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ENGINECEWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ENGINEICEWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ENGINEMGUKWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ENGINETCWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
