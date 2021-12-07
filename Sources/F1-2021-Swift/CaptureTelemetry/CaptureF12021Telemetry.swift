//
//  File.swift
//  
//
//  Created by Leigh McLean on 2/12/21.
//

import Foundation
import UDPReader

public class CaptureF12021Telemetry : CaptureTelemetry {
    
    let amount = 2048
    let creator = TelemetryF12021PacketCreator()
    var udp: Reader
    
    public init(reader: Reader) throws {
        self.udp = reader
    }
    
    public func capturePacket() -> (TelemetryPacket?) {
        guard var data = self.udp.read(amount: amount) else {
            return nil
        }

        return creator.create(from: &data)
    }
}
