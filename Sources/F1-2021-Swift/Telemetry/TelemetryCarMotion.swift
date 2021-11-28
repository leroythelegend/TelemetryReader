//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarMotion: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["WORLDPOSITIONX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["WORLDPOSITIONY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["WORLDPOSITIONZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["WORLDVELOCITYX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["WORLDVELOCITYY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["WORLDVELOCITYZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["WORLDFORWARDDIRX"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.telemetry["WORLDFORWARDDIRY"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.telemetry["WORLDFORWARDDIRZ"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.telemetry["WORLDRIGHTDIRX"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.telemetry["WORLDRIGHTDIRY"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.telemetry["WORLDRIGHTDIRZ"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.telemetry["GFORCELATERAL"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["GFORCELONGITUDINAL"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["GFORCEVERTICAL"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["YAW"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["PITCH"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ROLL"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}
