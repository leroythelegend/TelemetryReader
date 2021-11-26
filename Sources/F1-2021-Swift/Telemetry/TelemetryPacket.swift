//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

class TelemetryPacket {
    
    typealias TelemetryPackets = Dictionary<String, [Telemetry]>
    
    var telemetryPackets = TelemetryPackets()
    
    public func getTelemetryPackets(by name: String) throws -> [Telemetry] {
        guard let result = self.telemetryPackets[name] else {
            throw TelemetryError.unknown(telemetry: name)
        }
        return result
    }
}
