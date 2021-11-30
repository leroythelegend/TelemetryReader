//
//  File.swift
//  
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarDamagePacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)

        self.data["CARDAMAGE"]  = [TelemetryCarDamage](try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants))
    }
}
