//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetrySessionData: Telemetry {
    
    var marshalZone: [TelemetryMarshalZone] = []
    var weatherForeastSamples: [TelemetryWeatherForecastSample] = []
    
    let MaxNumMarshalZones = 21
    let MaxNumWeatherForeastSamples = 56

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["WEATHER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TRACKTEMPERATURE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["AIRTEMPERATURE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TOTALLAPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TRACKLENGTH"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["SESSIONTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TRACKID"] = try Decode<Int>().decodeByte(from: &iter)
        self.telemetry["FORMULA"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SESSIONTIMELEFT"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["SESSIONDURATION"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.telemetry["PITSPEEDLIMIT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["GAMEPAUSED"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ISSPECTATING"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SPECTATORCARINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SLIPRONATIVESUPPORT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMMARSHALZONES"] = try Decode<UInt>().decodeByte(from: &iter)
        
        marshalZone = try TelemetryPacket.createTelemetryData(data: &iter, size: MaxNumMarshalZones)
        
        self.telemetry["SAFETYCARSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NETWORKGAME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["NUMWEATHERFORECASTSAMPLES"] = try Decode<UInt>().decodeByte(from: &iter)
        
        weatherForeastSamples = try TelemetryPacket.createTelemetryData(data: &iter, size: MaxNumWeatherForeastSamples)
        
        self.telemetry["FORECASTACCURACY"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["AIDIFFICULTY"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SEASONLINKIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["WEEKENDLINKIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["SESSIONLINKIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["PITSTOPWINDOWIDEALLAP"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PITSTOPWINDOWLATESTLAP"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PITSTOPREJOINPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["STEERINGASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["BRAKINGASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["GEARBOXASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PITASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PITRELEASEASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["ERSASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DRSASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DYNAMICRACINGLINE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DYNAMICRACINGLINETYPE"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

