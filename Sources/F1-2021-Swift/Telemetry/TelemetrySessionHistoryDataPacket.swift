//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetrySessionHistoryDataPacket: TelemetryPacket {
    
    let MaxTyresInHistory = 8
    let MaxLapHistory = 100
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)

        self.data["SESSIONHISTORYDATA"] = [TelemetrySessionHistoryData](try TelemetryPacket.createTelemetryData(data: &iter))
        self.data["LAPHISTORYDATA"] = [TelemetryLapHistoryData](try TelemetryPacket.createTelemetryData(data: &iter, size: MaxLapHistory))
        self.data["TYRESTINTHISTORYDATA"] = [TelemetryTyreStintHistoryData](try TelemetryPacket.createTelemetryData(data: &iter, size: MaxTyresInHistory))
    }
}
