//
//  File.swift
//  
//
//  Created by Leigh McLean on 27/11/21.
//

import Foundation
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
        
        // get car damage telemetry
        var carTelemetry: [Telemetry] = []
        for _ in 1...NumberOfParticipants {
            carTelemetry.append(try TelemetryCar(data: &iter))
        }
        self.telemetryPackets["CARTELEMERTY"] = carTelemetry
        
        var carTelemetryData: [Telemetry] = []
        carTelemetryData.append(try TelemetryCarData(data: &iter))
        self.telemetryPackets["CARTELEMERTYDATA"] = carTelemetryData
    }
}
