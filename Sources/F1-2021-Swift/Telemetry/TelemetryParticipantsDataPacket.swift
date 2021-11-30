//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryParticipantsDataPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
       
        self.data["ACTIVECARS"] = [TelemetryActiveCars](try TelemetryPacket.createTelemetryData(data: &iter))
        self.data["PARTICIPANTDATA"] = [TelemetryParticipants](try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants))
    }
}
