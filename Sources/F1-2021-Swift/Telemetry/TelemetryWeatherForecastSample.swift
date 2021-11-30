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
    
        self.data["SESSIONTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TIMEOFFSET"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["WEATHER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TRACKTEMPERATURE"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["TRACKTEMPERATURECHANGE"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["AIRTEMPERATURE"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["AIRTEMPERATURECHANGE"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["RAINPERCENTAGE"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

