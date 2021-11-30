//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetrySessionDataPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
       
        let session = try TelemetrySessionData(data: &iter)
        let sessions: [TelemetrySessionData] = [session]
        
        self.data["SESSIONDATA"] = sessions
        self.data["MARSHALZONE"] = session.marshalZone
        self.data["WEATHERFORECASTSAMPLE"] = session.weatherForeastSamples
    }
}
