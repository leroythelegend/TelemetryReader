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
    
        self.data["LAPTIMEINMS"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["SECTOR1TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["SECTOR2TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["SECTOR3TIMEINMS"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["LAPVALIDBITFLAGS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
