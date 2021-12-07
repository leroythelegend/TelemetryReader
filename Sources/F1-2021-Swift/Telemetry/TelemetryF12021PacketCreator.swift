//
//  File.swift
//  
//
//  Created by Leigh McLean on 7/12/21.
//

import Foundation

public class TelemetryF12021PacketCreator: TelemetryPacketCreator {
    
    public func create(from data: inout Data) -> (TelemetryPacket?) {
        var iter = data.makeIterator()
        
        do {
            let header = try TelemetryHeader(data: &iter)
            
//            guard let packetHeader = header.data["PACKETHEADER"] else {
//                return nil
//            }
            
            guard let packetIDs = header.data["PACKETID"] else {
                return nil
            }
            
            guard let packetID = packetIDs.first else {
                return nil
            }
            
            iter = data.makeIterator()
            
            switch packetID {
            case 0:
                return try TelemetryMotionPacket(data: &iter)
            case 1:
                return try TelemetrySessionDataPacket(data: &iter)
            case 2:
                return try TelemetryLapDataPacket(data: &iter)
            case 3:
                return try TelemetryEventPacket(data: &iter)
            case 4:
                return try TelemetryParticipantsDataPacket(data: &iter)
            case 5:
                return try TelemetryCarSetupPacket(data: &iter)
            case 6:
                return try TelemetryCarPacket(data: &iter)
            case 7:
                return try TelemetryCarStatusPacket(data: &iter)
            case 8:
                return try TelemetryFinalClassificationPacket(data: &iter)
            case 9:
                return try TelemetryLobbyInfoPacket(data: &iter)
            case 10:
                return try TelemetryCarDamagePacket(data: &iter)
            case 11:
                return try TelemetrySessionHistoryDataPacket(data: &iter)
            default:
                return nil
            }
        }
        catch { // maybe log error here
            return nil
        }
    }
}
