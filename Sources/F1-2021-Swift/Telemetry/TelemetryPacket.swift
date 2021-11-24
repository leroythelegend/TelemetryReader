//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

protocol TelemetryPacket {
    
    typealias Telemetry = Dictionary<String, [Double]>
    typealias TelemetryPackets = Dictionary<String, Telemetry>
    
    func getTelemetryPackets(by telemetry: String) -> Telemetry
}
