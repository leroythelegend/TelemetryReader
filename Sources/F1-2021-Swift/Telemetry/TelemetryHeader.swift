//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

public class TelemetryHeader: Telemetry {
    public var data: [String : [Double]] = [:]
    
    public required init(data iter: inout Data.Iterator) throws {
        self.data["PACKETFORMAT"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["GAMEMAJORVERSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GAMEMINORVERSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PACKETVERSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PACKETID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SESSIONUID"] = try Decode<UInt>().decode8Bytes(from: &iter)
        self.data["SESSIONTIME"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FRAMEIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["PLAYERCARINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SECONDARYPLAYERCARINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

