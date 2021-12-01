//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

///
/// This details telemetry for all the cars in the race. It details various values that would be
/// recorded on the car such as speed, throttle application, DRS etc.
///
/// ```
/// struct CarTelemetryData
/// {
///     uint16    m_speed;                    // Speed of car in kilometres per hour
///     float     m_throttle;                 // Amount of throttle applied (0.0 to 1.0)
///     float     m_steer;                    // Steering (-1.0 (full lock left) to 1.0 (full lock right))
///     float     m_brake;                    // Amount of brake applied (0.0 to 1.0)
///     uint8     m_clutch;                   // Amount of clutch applied (0 to 100)
///     int8      m_gear;                     // Gear selected (1-8, N=0, R=-1)
///     uint16    m_engineRPM;                // Engine RPM
///     uint8     m_drs;                      // 0 = off, 1 = on
///     uint8     m_revLightsPercent;         // Rev lights indicator (percentage)
///     uint16    m_revLightsBitValue;        // Rev lights (bit 0 = leftmost LED, bit 14 = rightmost LED)
///     uint16    m_brakesTemperature[4];     // Brakes temperature (celsius)
///     uint8     m_tyresSurfaceTemperature[4]; // Tyres surface temperature (celsius)
///     uint8     m_tyresInnerTemperature[4]; // Tyres inner temperature (celsius)
///     uint16    m_engineTemperature;        // Engine temperature (celsius)
///     float     m_tyresPressure[4];         // Tyres pressure (PSI)
///     uint8     m_surfaceType[4];           // Driving surface, see appendices
/// }
/// ```
/// 

class TelemetryCar: Telemetry {
    var data: [String : [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {
        self.data["SPEED"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["THROTTLE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["STEER"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["BRAKE"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["CLUTCH"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["GEAR"] = try Decode<Int>().decodeByte(from: &iter)
        self.data["ENGINERPM"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["DRS"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REVLIGHTSPERCENT"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["REVLIGHTSBITVALUE"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["BRAKESTEMPERATURE"] = try Decode<UInt>().decode2Bytes(amount: 4, from: &iter)
        self.data["TYRESSURFACETEMPERATURE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.data["TYRESINNERTEMPERATURE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
        self.data["ENGINETEMPERATURE"] = try Decode<UInt>().decode2Bytes(from: &iter)
        self.data["TYRESPRESSURE"] = try Decode<Float>().decode4Bytes(amount: 4, from: &iter)
        self.data["SURFACETYPE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
    }
}
