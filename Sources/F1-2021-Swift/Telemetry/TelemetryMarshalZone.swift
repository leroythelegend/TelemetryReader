//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryMarshalZone: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["ZONESTART"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ZONEFLAG"] = try Decode<Int>().decodeByte(from: &iter)
    }
}
