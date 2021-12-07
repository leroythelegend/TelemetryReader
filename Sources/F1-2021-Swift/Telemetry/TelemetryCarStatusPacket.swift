//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarStatusPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)

        self.data["CARSTATUS"] = [TelemetryCarStatusData](try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants))
    }
}
