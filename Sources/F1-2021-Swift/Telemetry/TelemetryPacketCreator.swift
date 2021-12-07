//
//  File.swift
//  
//
//  Created by Leigh McLean on 7/12/21.
//

import Foundation

public protocol TelemetryPacketCreator {
    func create(from data: inout Data) -> (TelemetryPacket?)
}
