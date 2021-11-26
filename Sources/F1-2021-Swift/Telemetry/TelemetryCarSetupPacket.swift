//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarSetupPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
        
        // get car damage telemetry
        var carSetUpTelemetry: [Telemetry] = []
        for _ in 1...NumberOfParticipants {
            carSetUpTelemetry.append(try TelemetryCarSetup(data: &iter))
        }
        self.telemetryPackets["CARSETUP"] = carSetUpTelemetry
    }
}
