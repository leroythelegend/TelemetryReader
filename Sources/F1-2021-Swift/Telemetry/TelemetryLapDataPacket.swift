//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryLapDataPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
       
        let lapData: [TelemetryLapData] = try createTelemetryData(data: &iter, size: NumberOfParticipants)
        self.telemetryPackets["LAPDATA"] = lapData
    }
}
