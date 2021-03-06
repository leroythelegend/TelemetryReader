//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryLobbyInfo: Telemetry {
    
    let NationalityStringLength = 48
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["AICONTROLLED"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TEAMID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NATIONALITY"] = try Decode<UInt>().decodeByte(amount: NationalityStringLength, from: &iter)
        self.data["NAME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["CARNUMBER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["READYSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
