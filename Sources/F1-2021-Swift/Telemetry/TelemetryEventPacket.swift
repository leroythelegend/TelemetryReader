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
        
        self.data["EVENTSTRING"] = [TelemetryEvent](try TelemetryPacket.createTelemetryData(data: &iter))
        
        guard let data = self.data["EVENTSTRING"]?[0].data["EVENTSTRINGCODE"] else {
            throw TelemetryError.unknown(telemetry: "EVENTSTRINGCODE")
        }

        switch data.toString() {
        case "BUTN":
            let event: [TelemetryButtonsEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["BUTTONS"] = event
        case "FLBK":
            let event: [TelemetryFlashBackEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["FLASHBACK"] = event
        case "SGSV":
            let event: [TelemetryStopGoPenaltyServedEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["STOPGOPENALTYSERVED"] = event
        case "DTSV":
            let event: [TelemetryDriveThroughPenaltyServedEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["DRIVETHROUGHPENALTYSERVED"] = event
        case "STLG":
            let event: [TelemetryStartLightsEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["STARTLIGHTS"] = event
        case "SPTP":
            let event: [TelemetrySpeedTrapEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["SPEEDTRAP"] = event
        case "PENA":
            let event: [TelemetryPenaltyEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["PENALTY"] = event
        case "RCWN":
            let event: [TelemetryRaceWinnerEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["RACEWINNER"] = event
        case "TMPT":
            let event: [TelemetryTeamMateInPitsEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["TEAMMATEINPITS"] = event
        case "RTME":
            let event: [TelemetryRetirementEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["RETIREMENT"] = event
        case "FTLP":
            let event: [TelemetryFastestLapEvent] = try TelemetryPacket.createTelemetryData(data: &iter)
            self.data["FASTESTLAP"] = event
        case "SSTA", "SEND", "DRSE", "DRSD", "CHQF":
            break
        default:
            break // log unknown error
        }
    }
}
