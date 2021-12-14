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
    
    var menuFrame: UInt = 0
    var twoSecFrame: UInt = 0
    
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
        
        guard let packet = capturePacket() else {
            return ("empty", [])
        }
        
        guard let packetid = packet.getPacketType() else {
            return ("empty", [])
        }

        guard let frame = getFrame(packet) else {
            return ("empty", [])
        }
        
        switch packetid {
        case 0, 2, 6, 7:
            return getMenuFrames(&self.menuPackets, packet, frame)
        case 1, 5, 10:
            return getTwoSecondFrames(&self.sessionPackets, packet, frame)
        case 3:
            return ("event", getSinglePacket(&self.eventPackets, packet))
        case 4:
            return ("fiveSec", getSinglePacket(&self.participantPackets, packet))
        case 8:
            return ("endOfRace", getSinglePacket(&self.endOfRacePackets, packet))
        case 9:
            return ("lobby", getSinglePacket(&self.lobbyPackets, packet))
        case 11:
            return ("history", getSinglePacket(&self.historyPackets, packet))
        default:
            return ("empty", [])
        }
    }
    
    private func getSinglePacket(_ packets: inout [TelemetryPacket], _ packet: TelemetryPacket) -> [TelemetryPacket] {
        packets.append(packet)
        defer {
            packets.removeAll()
            packets.append(packet)
        }
        return packets
    }
    
    private func getMenuFrames(_ packets: inout [TelemetryPacket], _ packet: TelemetryPacket,_ frame: UInt) -> (frequency: String, telemetry: [TelemetryPacket]) {
        if self.menuFrame == 0 {
            self.menuFrame = frame
        }
        
        if self.menuFrame == frame {
            packets.append(packet)
        }
        
        if frame > menuFrame {
            self.menuFrame = frame
            defer {
                packets.removeAll()
                packets.append(packet)
            }
            return ("menu", packets)
        }
        return ("empty", [])
    }
    
    private func getTwoSecondFrames(_ packets: inout [TelemetryPacket], _ packet: TelemetryPacket,_ frame: UInt) -> (frequency: String, telemetry: [TelemetryPacket]) {
        if self.twoSecFrame == 0 {
            self.twoSecFrame = frame
        }
        
        if self.twoSecFrame == frame {
            packets.append(packet)
        }
        
        if frame > self.twoSecFrame {
            self.twoSecFrame = frame
            defer {
                packets.removeAll()
                packets.append(packet)
            }
            return ("twoSec", packets)
        }
        return ("empty", [])
    }
    
    private func getFrame(_ packet: TelemetryPacket) -> (UInt?) {
        guard let header = packet.data["PACKETHEADER"] else {
            return nil
        }
        
        guard let data = header.first else {
            return nil
        }
        
        guard let frameids = data.data["FRAMEIDENTIFIER"] else {
            return nil
        }
        
        guard let frameid = frameids.first else {
            return nil
        }
        
        return UInt(frameid)
    }
}
