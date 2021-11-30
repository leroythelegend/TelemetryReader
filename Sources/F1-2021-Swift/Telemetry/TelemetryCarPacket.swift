//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)

        let carTelemetry: [TelemetryCar] = try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants)
        self.data["CARTELEMERTY"] = carTelemetry
        
        let carTelemetryData: [TelemetryCarData] = try TelemetryPacket.createTelemetryData(data: &iter)
        self.data["CARTELEMERTYDATA"] = carTelemetryData
    }
}
