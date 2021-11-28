//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

class TelemetryHeader: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["PACKETFORMAT"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["GAMEMAJORVERSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["GAMEMINORVERSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PACKETVERSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PACKETID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SESSIONUID"] = try Decode<UInt>().decode8Bytes(from: &iter)
        self.telemetry["SESSIONTIME"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["FRAMEIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["PLAYERCARINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SECONDARYPLAYERCARINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

