//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryEventPacket: TelemetryPacket {
    
    override init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
        
        let eventString: [TelemetryEvent] = try createTelemetryData(data: &iter)
        self.telemetryPackets["EVENTSTRING"] = eventString
        
        switch String(try eventString[0].getTelemetryData(by: "EVENTSTRINGCODE").toString()) {
        case "BUTN":
            let event: [TelemetryButtonsEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["BUTTONS"] = event
        case "FLBK":
            let event: [TelemetryFlashBackEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["FLASHBACK"] = event
        case "SGSV":
            let event: [TelemetryStopGoPenaltyServedEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["STOPGOPENALTYSERVED"] = event
        case "DTSV":
            let event: [TelemetryDriveThroughPenaltyServedEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["DRIVETHROUGHPENALTYSERVED"] = event
        case "STLG":
            let event: [TelemetryStartLightsEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["STARTLIGHTS"] = event
        case "SPTP":
            let event: [TelemetrySpeedTrapEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["SPEEDTRAP"] = event
        case "PENA":
            let event: [TelemetryPenaltyEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["PENALTY"] = event
        case "RCWN":
            let event: [TelemetryRaceWinnerEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["RACEWINNER"] = event
        case "TMPT":
            let event: [TelemetryTeamMateInPitsEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["TEAMMATEINPITS"] = event
        case "RTME":
            let event: [TelemetryRetirementEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["RETIREMENT"] = event
        case "FTLP":
            let event: [TelemetryFastestLapEvent] = try createTelemetryData(data: &iter)
            self.telemetryPackets["FASTESTLAP"] = event
        case "SSTA", "SEND", "DRSE", "DRSD", "CHQF":
            break
        default:
            break // log unknown error
        }
    }
}
