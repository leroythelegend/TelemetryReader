//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

public class TelemetryPacket {
    
    typealias TelemetryPackets = Dictionary<String, [Telemetry]>
    var data = TelemetryPackets()
    
    let NumberOfParticipants = 22
    
    init(data iter: inout Data.Iterator) throws {
        self.data["PACKETHEADER"] = [TelemetryHeader](try TelemetryPacket.createTelemetryData(data: &iter))
    }
    
    public func getPacketType() -> (UInt?){
        guard let header = self.data["PACKETHEADER"] else {
            return nil
        }
        
        guard let data = header.first else {
            return nil
        }
        
        guard let packetids = data.data["PACKETID"] else {
            return nil
        }
        
        guard let packetid = packetids.first else {
            return nil
        }
        
        return UInt(packetid)
    }
    
    static public func createTelemetryData<T>(data iter: inout Data.Iterator, size: Int = 1) throws -> [T] where T: Telemetry {
        var telemetry: [T] = []
        for _ in 1...size {
            telemetry.append(try T(data: &iter))
        }
        return telemetry
    }
}
