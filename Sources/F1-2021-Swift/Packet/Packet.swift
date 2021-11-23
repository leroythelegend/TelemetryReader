//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

protocol Packet {
    associatedtype T
    
    typealias Telemetry = Dictionary<String, [T]>
    typealias TelemetryPackets = Dictionary<String, Telemetry>
    
    func getTelemetryPackets(by telemetry: String) -> Telemetry
}
