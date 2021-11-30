//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarMotion: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["WORLDPOSITIONX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["WORLDPOSITIONY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["WORLDPOSITIONZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["WORLDVELOCITYX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["WORLDVELOCITYY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["WORLDVELOCITYZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["WORLDFORWARDDIRX"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.data["WORLDFORWARDDIRY"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.data["WORLDFORWARDDIRZ"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.data["WORLDRIGHTDIRX"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.data["WORLDRIGHTDIRY"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.data["WORLDRIGHTDIRZ"] = try Decode<Int>().decode2Bytes(from: &iter)
        self.data["GFORCELATERAL"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["GFORCELONGITUDINAL"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["GFORCEVERTICAL"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["YAW"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["PITCH"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ROLL"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}
