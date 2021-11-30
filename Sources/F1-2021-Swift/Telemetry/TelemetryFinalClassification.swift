//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryFinalClassification: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {    
        self.data["POSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMLAPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GRIDPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["POINTS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMPITSTOPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["RESULTSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BESTLAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["TOTALRACETIME"] = try Decode<Double>().decode4Bytes(from: &iter)
        self.data["PENALTIESTIME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMPENALTIES"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMTYRESTINTS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TYRESTINTSACTUAL"] = try Decode<UInt>().decodeByte(amount: 8, from: &iter)
        self.data["TYRESTINTSVISUAL"] = try Decode<UInt>().decodeByte(amount: 8, from: &iter)
    }
}
