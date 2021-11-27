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
        
        var eventString: [Telemetry] = []
        eventString.append(try TelemetryEvent(data: &iter))
        self.telemetryPackets["EVENTSTRING"] = eventString
        
        var event: [Telemetry] = []
        switch String(try eventString[0].getTelemetry(by: "EVENTSTRINGCODE").toString()) {
        case "BUTN":
            event.append(try TelemetryButtonsEvent(data: &iter))
            self.telemetryPackets["BUTTONS"] = event
        case "FLBK":
            event.append(try TelemetryFlashBackEvent(data: &iter))
            self.telemetryPackets["FLASHBACK"] = event
        case "SGSV":
            event.append(try TelemetryStopGoPenaltyServedEvent(data: &iter))
            self.telemetryPackets["STOPGOPENALTYSERVED"] = event
        case "DTSV":
            event.append(try TelemetryDriveThroughPenaltyServedEvent(data: &iter))
            self.telemetryPackets["DRIVETHROUGHPENALTYSERVED"] = event
        case "STLG":
            event.append(try TelemetryStartLightsEvent(data: &iter))
            self.telemetryPackets["STARTLIGHTS"] = event
        case "SPTP":
            event.append(try TelemetrySpeedTrapEvent(data: &iter))
            self.telemetryPackets["SPEEDTRAP"] = event
        case "PENA":
            event.append(try TelemetryPenaltyEvent(data: &iter))
            self.telemetryPackets["PENALTY"] = event
        case "RCWN":
            event.append(try TelemetryRaceWinnerEvent(data: &iter))
            self.telemetryPackets["RACEWINNER"] = event
        case "TMPT":
            event.append(try TelemetryTeamMateInPitsEvent(data: &iter))
            self.telemetryPackets["TEAMMATEINPITS"] = event
        case "RTME":
            event.append(try TelemetryRetirementEvent(data: &iter))
            self.telemetryPackets["RETIREMENT"] = event
        case "FTLP":
            event.append(try TelemetryFastestLapEvent(data: &iter))
            self.telemetryPackets["FASTESTLAP"] = event
        case "SSTA", "SEND", "DRSE", "DRSD", "CHQF":
            break // need to think how too signal these events
        default:
            break // log unknown error
        }
    }
}
