//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryLapHistoryData: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["LAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["SECTOR1TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["SECTOR2TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["SECTOR3TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["LAPVALIDBITFLAGS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
