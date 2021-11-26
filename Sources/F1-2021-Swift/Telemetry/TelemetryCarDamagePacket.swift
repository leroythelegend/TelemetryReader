//
//  File.swift
//  
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarDamagePacket: TelemetryPacket {
    
    init(data iter: inout Data.Iterator) throws {
        super.init()
        
        // get header data
        var header: [Telemetry] = []
        header.append(try TelemetryHeader(data: &iter))
        self.telemetryPackets["PACKETHEADER"] = header
        
        // get car damage telemetry
        var carDamageTelemetry: [Telemetry] = []
        for _ in 1...22 {
            carDamageTelemetry.append(try TelemetryCarDamage(data: &iter))
        }
        self.telemetryPackets["CARDAMAGE"] = carDamageTelemetry
    }
}
