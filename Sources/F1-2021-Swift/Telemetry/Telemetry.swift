//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

class Telemetry {
    
    let DescriptionStringLength = 48
    var data: [String: [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {}
    
    func getTelemetryData(by name: String) throws -> [Double] {
        guard let result = data[name] else {
            throw TelemetryError.unknown(telemetry: name)
        }
        return result
    }
}


