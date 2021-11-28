//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryParticipants: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["AICONTROLLED"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DRIVERID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NETWORKID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TEAMID"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["MYTEAM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["RACENUMBER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NATIONALITY"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NAME"] = try Decode<UInt>().decodeByte(amount: DescriptionStringLength, from: &iter)
        self.telemetry["YOURTELEMETRY"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
