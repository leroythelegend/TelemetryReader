//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryFinalClassificationPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
        
        var carNumClassification: [Telemetry] = []
        carNumClassification.append(try TelemetryNumberClassificationCars(data: &iter))
        self.telemetryPackets["NUMCARS"] = carNumClassification
        
        var carFinalClassification: [Telemetry] = []
        for _ in 1...NumberOfParticipants {
            carFinalClassification.append(try TelemetryFinalClassification(data: &iter))
        }
        self.telemetryPackets["FINALCLASSIFICATIONDATA"] = carFinalClassification
    }
}
