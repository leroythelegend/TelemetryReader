//
//  File.swift
//  
//
//  Created by Leigh McLean on 2/12/21.
//

import Foundation

protocol CaptureTelemetry {
    func capture() -> [TelemetryPacket]
}
