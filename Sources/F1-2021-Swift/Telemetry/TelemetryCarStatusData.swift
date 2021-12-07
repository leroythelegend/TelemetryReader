//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarStatusData: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["TRACTIONCONTROL"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ANTILOCKBRAKES"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FUELMIX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FRONTBRAKEBIAS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PITLIMITERSTATUS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["FUELINTANK"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FUELCAPACITY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["FUELREMAININGLAPS"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["MAXRPM"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["IDLERPM"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["MAXGEARS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DRSALLOWED"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DRSACTIVATIONDISTANCE"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["ACTUALTYRECOMPOUND"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["VISUALTYRECOMPOUND"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TYRESAGELAPS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["VEHICLEFIAFLAGS"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["ERSSTOREENERGY"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ERSDEPLOYMODE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["ERSHARVESTEDTHISLAPMGUK"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ERSHARVESTEDTHISLAPMGUH"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["ERSDEPLOYEDTHISLAP"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["NETWORKPAUSED"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
