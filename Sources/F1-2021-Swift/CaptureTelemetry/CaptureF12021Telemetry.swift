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
    var udp: Reader
    
    public init(reader: Reader) throws {
        self.udp = reader
    }
    
    public func capturePacket() -> (TelemetryPacket?) {
        guard var data = self.udp.read(amount: amount) else {
            return nil
        }
        
        guard let packetID = getPacketID(&data) else {
            return nil
        }
        
        return nil
    }
    
    private func getPacketID(_ data: inout Data) -> (UInt?) {
        var iter = data.makeIterator()
        
        do {
            let header = try TelemetryHeader(data: &iter)
            
            guard let packetHeader = header.data["PACKETHEADER"] else {
                return nil
            }
            
            guard let result = packetHeader.first else {
                return nil
            }
            
            return UInt(result)
        }
        catch {
            return nil
        }
    }
}
