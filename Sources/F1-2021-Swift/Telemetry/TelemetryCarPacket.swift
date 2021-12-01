//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

///
/// This packet details telemetry for all the cars in the race. It details various values that would be recorded on the car such as speed, throttle application, DRS
/// etc. Note that the rev light configurations are presented separately as well and will mimic real life driver preferences.
///
/// Frequency: Rate as specified in menus
/// Size: 1347 bytes
/// Version: 1
///
/// F1 2021 API
/// ```
/// struct PacketCarTelemetryData
/// {
///     PacketHeader        m_header;          // Header
///
///     CarTelemetryData    m_carTelemetryData[22];
///
///     uint8               m_mfdPanelIndex;       // Index of MFD panel open - 255 = MFD closed
///                                                // Single player, race – 0 = Car setup, 1 = Pits
///                                                // 2 = Damage, 3 =  Engine, 4 = Temperatures
///                                                // May vary depending on game mode
///     uint8               m_mfdPanelIndexSecondaryPlayer;   // See above
///     int8                m_suggestedGear;       // Suggested gear for the player (1-8)
///                                                // 0 if no gear suggested
/// };
/// ```
/// 

class TelemetryCarPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)

        let carTelemetry: [TelemetryCar] = try TelemetryPacket.createTelemetryData(data: &iter, size: NumberOfParticipants)
        self.data["CARTELEMERTY"] = carTelemetry
        
        let carTelemetryData: [TelemetryCarData] = try TelemetryPacket.createTelemetryData(data: &iter)
        self.data["CARTELEMERTYDATA"] = carTelemetryData
    }
}
