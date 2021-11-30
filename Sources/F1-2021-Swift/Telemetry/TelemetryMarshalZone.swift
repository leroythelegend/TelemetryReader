//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryMarshalZone: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {    
        self.data["ZONESTART"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ZONEFLAG"] = try Decode<Int>().decodeByte(from: &iter)
    }
}
