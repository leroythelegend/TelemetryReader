//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryWeatherForecastSample: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["SESSIONTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TIMEOFFSET"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["WEATHER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TRACKTEMPERATURE"] = try Decode<Int>().decodeByte(from: &iter)
        self.telemetry["TRACKTEMPERATURECHANGE"] = try Decode<Int>().decodeByte(from: &iter)
        self.telemetry["AIRTEMPERATURE"] = try Decode<Int>().decodeByte(from: &iter)
        self.telemetry["AIRTEMPERATURECHANGE"] = try Decode<Int>().decodeByte(from: &iter)
        self.telemetry["RAINPERCENTAGE"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

