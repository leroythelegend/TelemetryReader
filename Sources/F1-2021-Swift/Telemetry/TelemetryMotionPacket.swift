//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryMotionPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)

        self.data["CARMOTIONDATA"] = [TelemetryCarMotion](try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants))
        self.data["MOTIONDATA"] = [TelemetryMotion](try TelemetryPacket.createTelemetryData(data: &iter))
    }
}
