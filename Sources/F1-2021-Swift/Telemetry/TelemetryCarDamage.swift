//
//  File.swift
//  
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarDamage: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["TYRESWEAR"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["TYRESDAMAGE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.data["BRAKESDAMAGE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.data["FRONTLEFTWINGDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FRONTRIGHTWINGDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REARWINGDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FLOORDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DIFFUSERDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SIDEPODDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DRSFAULT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GEARBOXDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ENGINEDAMAGE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ENGINEMGUHWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ENGINEESWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ENGINECEWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ENGINEICEWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ENGINEMGUKWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ENGINETCWEAR"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
