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
     
        self.data["NUMCARS"] = [TelemetryNumberClassificationCars](try TelemetryPacket.createTelemetryData(data: &iter))
        self.data["FINALCLASSIFICATIONDATA"] = [TelemetryFinalClassification](try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants))
    }
}
