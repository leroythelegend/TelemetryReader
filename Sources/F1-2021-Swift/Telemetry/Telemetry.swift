//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

class Telemetry {
    
    var telemetry: [String: [Double]] = [:]
    
    func getTelemetry(by name: String) throws -> [Double] {
        guard let result = telemetry[name] else {
            throw TelemetryError.unknown(telemetry: name)
        }
        return result
    }
}
