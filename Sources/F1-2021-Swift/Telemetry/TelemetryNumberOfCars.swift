//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryNumberClassificationCars: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["NUMCLASSIFICATIONCARS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
