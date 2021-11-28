//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryLapData: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["LASTLAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["CURRENTLAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["SECTOR1TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["SECTOR2TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["LAPDISTANCE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["TOTALDISTANCE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["SAFETYCARDELTA"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["CARPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["CURRENTLAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PITSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMPITSTOPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SECTOR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["CURRENTLAPINVALID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PENALTIES"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["WARNINGS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMUNSERVEDDRIVETHROUGHPENS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMUNSERVEDSTOPGOPENS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["GRIDPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DRIVERSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["RESULTSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PITLANETIMERACTIVE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PITLANETIMEINLANEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["PITSTOPTIMERINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["PITSTOPSHOULDSERVEPEN"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

