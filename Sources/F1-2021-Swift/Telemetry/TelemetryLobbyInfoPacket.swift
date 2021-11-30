//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryLobbyInfoPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
       
        self.data["NUMPLAYERS"] = [TelemetryNumberOfPlayers](try TelemetryPacket.createTelemetryData(data: &iter))
        self.data["LOBBYINFODATA"] = [TelemetryLobbyInfo](try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants))
    }
}
