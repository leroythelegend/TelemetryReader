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
    
    let NumberOfParticipants = 22
    
    init(data iter: inout Data.Iterator) throws {
        // get header data
        var header: [Telemetry] = []
        header.append(try TelemetryHeader(data: &iter))
        self.telemetryPackets["PACKETHEADER"] = header
    }

    
    public func getTelemetryPackets(by name: String) throws -> [Telemetry] {
        guard let result = self.telemetryPackets[name] else {
            throw TelemetryError.unknown(telemetry: name)
        }
        return result
    }
}
