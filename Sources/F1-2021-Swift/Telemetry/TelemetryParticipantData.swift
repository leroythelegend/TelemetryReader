//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryParticipants: Telemetry {
    let NamaeStringLength = 48
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["AICONTROLLED"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DRIVERID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NETWORKID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TEAMID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["MYTEAM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["RACENUMBER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NATIONALITY"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NAME"] = try Decode<UInt>().decodeByte(amount: NamaeStringLength, from: &iter)
        self.data["YOURTELEMETRY"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
