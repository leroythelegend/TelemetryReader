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
       
        let activeCars: [TelemetryActiveCars] = try TelemetryPacket.createTelemetryData(data: &iter)
        self.telemetryPackets["ACTIVECARS"] = activeCars

        let participants: [TelemetryParticipants] = try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants)
        self.telemetryPackets["PARTICIPANTDATA"] = participants
    }
}
