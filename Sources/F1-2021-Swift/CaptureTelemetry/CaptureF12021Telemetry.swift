//
//  File.swift
//  
//
//  Created by Leigh McLean on 2/12/21.
//

import Foundation
import UDPReader

class CaptureF12021Telemetry : CaptureTelemetry {
    
    var udp: UDPReader
    
    init(listen port: String) throws {
        self.udp = try UDPReader(listen: port)
    }
    
    func capture() -> [TelemetryPacket] {
        // read packet
        // decode header to find what packet to decode
        // decode the frame
        // decode telemetrypacket
        
        return []
    }
}
