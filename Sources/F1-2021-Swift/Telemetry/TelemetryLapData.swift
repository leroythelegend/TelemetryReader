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
    
        self.data["LASTLAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["CURRENTLAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["SECTOR1TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["SECTOR2TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["LAPDISTANCE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["TOTALDISTANCE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["SAFETYCARDELTA"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["CARPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["CURRENTLAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMPITSTOPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SECTOR"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["CURRENTLAPINVALID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PENALTIES"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["WARNINGS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMUNSERVEDDRIVETHROUGHPENS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMUNSERVEDSTOPGOPENS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GRIDPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DRIVERSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["RESULTSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITLANETIMERACTIVE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITLANETIMEINLANEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["PITSTOPTIMERINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["PITSTOPSHOULDSERVEPEN"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

