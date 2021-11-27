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

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["MFDPANELINDEX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["MFDPANELINDEXSECONDARYPLAYER"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SUGGESTEDGEAR"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}
