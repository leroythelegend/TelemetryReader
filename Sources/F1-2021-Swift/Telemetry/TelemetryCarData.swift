//
//  File.swift
//  
//
//  Created by Leigh McLean on 27/11/21.
//

import Foundation
//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryCarData: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["MFDPANELINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["MFDPANELINDEXSECONDARYPLAYER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SUGGESTEDGEAR"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
