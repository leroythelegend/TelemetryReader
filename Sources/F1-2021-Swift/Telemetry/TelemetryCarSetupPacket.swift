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

        self.data["CARSETUP"] = [TelemetryCarSetup](try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants))
    }
}
