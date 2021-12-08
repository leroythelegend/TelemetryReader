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
    
    var menuPackets: [TelemetryPacket] = []
    var sessionPackets: [TelemetryPacket] = []
    var eventPackets: [TelemetryPacket] = []
    var participantPackets: [TelemetryPacket] = []
    var endOfRacePackets: [TelemetryPacket] = []
    var lobbyPackets: [TelemetryPacket] = []
    var historyPackets: [TelemetryPacket] = []
    
    public init(reader: Reader) throws {
        self.udp = reader
    }
    
    public func capturePacket() -> (TelemetryPacket?) {
        guard var data = self.udp.read(amount: amount) else {
            return nil
        }

        return creator.create(from: &data)
    }
    
    public func capturePackets() -> (frequency: String, telemetry: [TelemetryPacket]) {
        
        // Menu Motion, Lap Data, Car Telemetry, Car Status
        // 2 per second Session, car setups, Car damage
        // Event
        // 5 seconds Participants
        // End of Race
        // 2 per second in lobby lobby
        // 20 per second but cycling through cars Session history
        
        guard let packet = capturePacket() else {
            return ("empty", [])
        }
        
        guard let packetid = packet.getPacketType() else {
            return ("empty", [])
        }

        switch packetid {
        case 0, 2, 6, 7:
            return ("menu", menuPackets)
        default:
            return ("empty", [])
        }
    }
}
