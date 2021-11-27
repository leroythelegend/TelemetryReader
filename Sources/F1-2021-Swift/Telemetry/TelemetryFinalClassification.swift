//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryFinalClassification: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["POSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMLAPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["GRIDPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["POINTS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMPITSTOPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["RESULTSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BESTLAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["TOTALRACETIME"] = try Decode<Double>().decode4Bytes(from: &iter)
        self.telemetry["PENALTIESTIME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMPENALTIES"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMTYRESTINTS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TYRESTINTSACTUAL"] = try Decode<UInt>().decodeByte(amount: 8, from: &iter)
        self.telemetry["TYRESTINTSVISUAL"] = try Decode<UInt>().decodeByte(amount: 8, from: &iter)
    }
}
