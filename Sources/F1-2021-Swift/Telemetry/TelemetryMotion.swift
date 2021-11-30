//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryMotion: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {   
        self.data["SUSPENSIONPOSITION"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["SUSPENSIONVELOCITY"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["SUSPENSIONACCELERATION"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["WHEELSPEED"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["WHEELSLIP"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["LOCALVELOCITYX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["LOCALVELOCITYY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["LOCALVELOCITYZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ANGULARVELOCITYX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ANGULARVELOCITYY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ANGULARVELOCITYZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ANGULARACCELERATIONX"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ANGULARACCELERATIONY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ANGULARACCELERATIONZ"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FRONTWHEELSANGLE"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}

