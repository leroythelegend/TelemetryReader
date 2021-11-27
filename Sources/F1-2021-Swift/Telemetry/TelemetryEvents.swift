//
//  File.swift
//
//
//  Created by Leigh McLean on 25/11/21.
//

import Foundation

class TelemetryFastestLapEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["LAPTIME"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}

class TelemetryRetirementEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

typealias TelemetryTeamMateInPitsEvent = TelemetryRetirementEvent
typealias TelemetryRaceWinnerEvent = TelemetryRetirementEvent
typealias TelemetryStopGoPenaltyServedEvent = TelemetryRetirementEvent
typealias TelemetryDriveThroughPenaltyServedEvent = TelemetryRetirementEvent

class TelemetryPenaltyEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["PENALTYTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["INFRINGEMENTTYPE"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["OTHERVEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["TIME"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["LAPNUM"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["PLACESGAINED"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

class TelemetrySpeedTrapEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["VEHICLEIDX"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["SPEED"] = try Decode<Float>().decode4Bytes(from: &iter)
        self.telemetry["OVERALLFASTESTINSESSION"] = try Decode<UInt>().decodeByte(from: &iter)
        self.telemetry["DRIVERFASTESTINSESSION"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}


class TelemetryStartLightsEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["NUMLIGHTS"] = try Decode<UInt>().decodeByte(from: &iter)
    }
}

class TelemetryButtonsEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["BUTTONSTATUS"] = try Decode<UInt>().decode4Bytes(from: &iter)
    }
}


class TelemetryFlashBackEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["FLASHBACKFRAMEIDENTIFIER"] = try Decode<UInt>().decode4Bytes(from: &iter)
        self.telemetry["FLASHBACKSESSIONTIME"] = try Decode<Float>().decode4Bytes(from: &iter)
    }
}


class TelemetryEvent: Telemetry {

    init(data iter: inout Data.Iterator) throws {
        super.init()
    
        self.telemetry["EVENTSTRINGCODE"] = try Decode<UInt>().decodeByte(amount: 4, from: &iter)
    }
}
