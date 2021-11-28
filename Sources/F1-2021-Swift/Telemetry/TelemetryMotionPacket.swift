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

        let carMotion: [TelemetryCarMotion] = try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants)
        self.telemetryPackets["CARMOTIONDATA"] = carMotion
    
        let motion: [TelemetryMotion] = try TelemetryPacket.createTelemetryData(data: &iter)
        self.telemetryPackets["MOTIONDATA"] = motion
    }
}
