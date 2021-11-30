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

        let sessionHistoryData: [TelemetrySessionHistoryData] = try TelemetryPacket.createTelemetryData(data: &iter)
        self.data["SESSIONHISTORYDATA"] = sessionHistoryData
    
        let lapHistoryData: [TelemetryLapHistoryData] = try TelemetryPacket.createTelemetryData(data: &iter, size: MaxLapHistory)
        self.data["LAPHISTORYDATA"] = lapHistoryData
        
        let tyreStintHistoryData: [TelemetryTyreStintHistoryData] = try TelemetryPacket.createTelemetryData(data: &iter, size: MaxTyresInHistory)
        self.data["TYRESTINTHISTORYDATA"] = tyreStintHistoryData
    }
}
