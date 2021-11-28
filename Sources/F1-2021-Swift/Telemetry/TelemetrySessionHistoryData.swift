//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetrySessionHistoryData: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["CARIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMLAPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMTYRESTINTS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BESTLAPTIMELAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BESTSECTOR1LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BESTSECTOR2LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BESTSECTOR3LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}


