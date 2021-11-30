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
    
        self.data["CARIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMLAPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMTYRESTINTS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BESTLAPTIMELAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BESTSECTOR1LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BESTSECTOR2LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BESTSECTOR3LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}


