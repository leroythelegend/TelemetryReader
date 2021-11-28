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
     
        let carNumClassification: [TelemetryNumberClassificationCars] = try createTelemetryData(data: &iter)
        self.telemetryPackets["NUMCARS"] = carNumClassification
       
        let carFinalClassification: [TelemetryFinalClassification] = try createTelemetryData(data: &iter, size: NumberOfParticipants)
        self.telemetryPackets["FINALCLASSIFICATIONDATA"] = carFinalClassification
    }
}
