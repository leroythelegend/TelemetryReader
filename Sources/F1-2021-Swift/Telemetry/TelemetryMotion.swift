//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryMotion: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.telemetry["SUSPENSIONPOSITION"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.telemetry["SUSPENSIONVELOCITY"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.telemetry["SUSPENSIONACCELERATION"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.telemetry["WHEELSPEED"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.telemetry["WHEELSLIP"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.telemetry["LOCALVELOCITYX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["LOCALVELOCITYY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["LOCALVELOCITYZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ANGULARVELOCITYX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ANGULARVELOCITYY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ANGULARVELOCITYZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ANGULARACCELERATIONX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ANGULARACCELERATIONY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["ANGULARACCELERATIONZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["FRONTWHEELSANGLE"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}

