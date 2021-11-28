//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryTyreStintHistoryData: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["ENDLAP"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TYREACTUALCOMPOUND"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TYREVISUALCOMPOUND"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

