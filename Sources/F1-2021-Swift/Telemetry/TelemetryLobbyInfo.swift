//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryLobbyInfo: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["AICONTROLLED"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TEAMID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NATIONALITY"] = try Decode<UInt>().decodeByte(amount: 48, from: &iter)
        self.telemetry["NAME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["CARNUMBER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["READYSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
