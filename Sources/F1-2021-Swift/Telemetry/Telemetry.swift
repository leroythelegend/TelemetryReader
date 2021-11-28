//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

class Telemetry {
    
    var telemetry: [String: [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {}
    
    func getTelemetryData(by name: String) throws -> [Double] {
        guard let result = telemetry[name] else {
            throw TelemetryError.unknown(telemetry: name)
        }
        return result
    }
}

extension Array where Element == Double {
    
    func toString() -> String {
        var result: String = String()
        for d in self {
            result.append(Character(Unicode.Scalar(Int(d))!))
        }
        return result
    }
    
    func and(at i: Int, with: UInt) -> UInt {
        return UInt(self[i]) & with
    }
}
