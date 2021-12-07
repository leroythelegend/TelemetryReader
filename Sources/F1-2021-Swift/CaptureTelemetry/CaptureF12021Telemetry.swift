//
//  File.swift
//  
//
//  Created by Leigh McLean on 2/12/21.
//

import Foundation
import UDPReader

public class CaptureF12021Telemetry : CaptureTelemetry {
    
    var udp: Reader
    
    public init(reader: Reader) throws {
        self.udp = reader
    }
    
    public func capturePacket() -> TelemetryPacket? {
        
        return nil
    }
}
