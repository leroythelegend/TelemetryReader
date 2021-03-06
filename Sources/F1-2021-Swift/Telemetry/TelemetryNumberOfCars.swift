//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryNumberClassificationCars: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["NUMCLASSIFICATIONCARS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
