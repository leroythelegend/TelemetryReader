//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

///
/// Number of active cars in the data – should match number of cars on HUD
///

class TelemetryActiveCars: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["NUMACTIVECARS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
