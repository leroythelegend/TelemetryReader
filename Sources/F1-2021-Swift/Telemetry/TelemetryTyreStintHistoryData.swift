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
    
        self.data["ENDLAP"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TYREACTUALCOMPOUND"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TYREVISUALCOMPOUND"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

