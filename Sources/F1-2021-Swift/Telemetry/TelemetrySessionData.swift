//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetrySessionData: Telemetry {
    var data: [String : [Double]] = [:]
    
    var marshalZone: [TelemetryMarshalZone] = []
    var weatherForeastSamples: [TelemetryWeatherForecastSample] = []
    
    let MaxNumMarshalZones = 21
    let MaxNumWeatherForeastSamples = 56

    required init(data iter: inout Data.Iterator) throws {
        self.data["WEATHER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TRACKTEMPERATURE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["AIRTEMPERATURE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TOTALLAPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TRACKLENGTH"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["SESSIONTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TRACKID"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["FORMULA"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SESSIONTIMELEFT"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["SESSIONDURATION"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["PITSPEEDLIMIT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GAMEPAUSED"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ISSPECTATING"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SPECTATORCARINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SLIPRONATIVESUPPORT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMMARSHALZONES"] = try Decode<UInt>().decodeByte(from: &iter)
        
        marshalZone = try TelemetryPacket.createTelemetryData(data: &iter, size: MaxNumMarshalZones)
        
        self.data["SAFETYCARSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NETWORKGAME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["NUMWEATHERFORECASTSAMPLES"] = try Decode<UInt>().decodeByte(from: &iter)
        
        weatherForeastSamples = try TelemetryPacket.createTelemetryData(data: &iter, size: MaxNumWeatherForeastSamples)
        
        self.data["FORECASTACCURACY"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["AIDIFFICULTY"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SEASONLINKIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["WEEKENDLINKIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["SESSIONLINKIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["PITSTOPWINDOWIDEALLAP"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITSTOPWINDOWLATESTLAP"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITSTOPREJOINPOSITION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["STEERINGASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["BRAKINGASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GEARBOXASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITRELEASEASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ERSASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DRSASSIST"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DYNAMICRACINGLINE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DYNAMICRACINGLINETYPE"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

