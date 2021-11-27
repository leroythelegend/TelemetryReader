//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryNumberClassificationCars: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["NUMCLASSIFICATIONCARS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
