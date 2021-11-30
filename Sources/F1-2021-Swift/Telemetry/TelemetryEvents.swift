//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryFastestLapEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["LAPTIME"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}

class TelemetryRetirementEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

typealias TelemetryTeamMateInPitsEvent = TelemetryRetirementEvent
typealias TelemetryRaceWinnerEvent = TelemetryRetirementEvent
typealias TelemetryStopGoPenaltyServedEvent = TelemetryRetirementEvent
typealias TelemetryDriveThroughPenaltyServedEvent = TelemetryRetirementEvent

class TelemetryPenaltyEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["PENALTYTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["INFRINGEMENTTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["OTHERVEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["TIME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["PLACESGAINED"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

class TelemetrySpeedTrapEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["SPEED"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.data["OVERALLFASTESTINSESSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.data["DRIVERFASTESTINSESSION"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}


class TelemetryStartLightsEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["NUMLIGHTS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

class TelemetryButtonsEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["BUTTONSTATUS"] = try Decode<UInt>().decode4Bytes(from: &iter)
    }
}


class TelemetryFlashBackEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["FLASHBACKFRAMEIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.data["FLASHBACKSESSIONTIME"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}


class TelemetryEvent: Telemetry {

    required init(data iter: inout Data.Iterator) throws {
        try super.init(data: &iter)
    
        self.data["EVENTSTRINGCODE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
    }
}
