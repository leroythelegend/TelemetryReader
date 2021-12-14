import XCTest
@testable import F1_2021_Swift
import UDPReader

final class F1_2021_SwiftTests: XCTestCase {
    func testDecodeFloat() throws {

        let decodeFloat = Decode<Float>()
        let decodeUInt = Decode<UInt>()
        
        // Test we throw if we past the size of the data
        let empty = Data()
        var emptyIter = empty.makeIterator()
        
        XCTAssertThrowsError(try decodeFloat.decode4Bytes(from: &emptyIter), "An OutOfBounds error should have been thrown") { error in
            XCTAssertEqual(error as? DecodeError, DecodeError.OutOfBounds)
        }
        
        // Test we can decode four bytes
        
        let bytes: [UInt8] = [0x92,0xCB,0x8F,0xF0,0x01,0x02,0x04,0x05]
        let data = Data(bytes)
        var iter = data.makeIterator()
        
        XCTAssertEqual(try! decodeFloat.decode4Bytes(from: &iter).first!, -3.5601966249072491e+29)
        
        // Reset iterator
        iter = data.makeIterator()

        XCTAssertEqual(try! decodeUInt.decode2Bytes(from: &iter).first!, 0xCB92)
        XCTAssertEqual(try! decodeUInt.decodeByte(from: &iter).first!, 0x8F)
        
        // Note because I'm converting a UInt64 to double it is not accurate
        // however the 64 bit if F1-2021 is only used as a unique serial number
        iter = data.makeIterator()
        XCTAssertEqual(try! decodeUInt.decode8Bytes(from: &iter).first!, 4119579027)
    }
    
    func testAnd() throws {
        let value: [Double] = [0x10101010]
        
        XCTAssert(value.and(at: 0, with: 0x00000010) != 0)
        XCTAssert(value.and(at: 0, with: 0x00000000) == 0)
        XCTAssert(value.and(at: 0, with: 0x01010101) == 0)
        XCTAssert(value.and(at: 0, with: 0x10101010) != 0)
        XCTAssert(value.and(at: 0, with: 0x00001000) != 0)
        XCTAssert(value.and(at: 0, with: 0x00100000) != 0)
        XCTAssert(value.and(at: 0, with: 0x10000000) != 0)
    }
    
    func testTelemetryHeader() throws {
        
        let eventPacket = getDataFromTest(vector: "event_packet")

        var iter = eventPacket.makeIterator()
        let header = try? TelemetryHeader(data: &iter)
        
        XCTAssertEqual(header?.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.data["GAMEMINORVERSION"]?.first!, 4)
        XCTAssertEqual(header?.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.data["PACKETID"]?.first!, 3)
        XCTAssertEqual(header?.data["SESSIONUID"]?.first!, 2741612942)
        XCTAssertEqual(header?.data["SESSIONTIME"]?.first!, 80.485137939453125)
        XCTAssertEqual(header?.data["FRAMEIDENTIFIER"]?.first!, 1684)
        XCTAssertEqual(header?.data["PLAYERCARINDEX"]?.first!, 0)
        XCTAssertEqual(header?.data["SECONDARYPLAYERCARINDEX"]?.first!, 255)

    }
    
    func testTelemetryCarDamage() throws {
        
        var data = getDataFromTest(vector: "car_damage")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 10)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 8)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 10)
        
        let cardamage = packet?.data["CARDAMAGE"]
        
        XCTAssertEqual(cardamage?[0].data["TYRESWEAR"]?[0], 0)
        XCTAssertEqual(cardamage?[0].data["TYRESWEAR"]?[1], 0)
        XCTAssertEqual(cardamage?[0].data["TYRESWEAR"]?[2], 0)
        XCTAssertEqual(cardamage?[0].data["TYRESWEAR"]?[3], 0)
        XCTAssertEqual(cardamage?[0].data["TYRESDAMAGE"]?[0], 0)
        XCTAssertEqual(cardamage?[0].data["TYRESDAMAGE"]?[1], 0)
        XCTAssertEqual(cardamage?[0].data["TYRESDAMAGE"]?[2], 0)
        XCTAssertEqual(cardamage?[0].data["TYRESDAMAGE"]?[3], 0)
        XCTAssertEqual(cardamage?[0].data["BRAKESDAMAGE"]?[0], 0)
        XCTAssertEqual(cardamage?[0].data["BRAKESDAMAGE"]?[1], 0)
        XCTAssertEqual(cardamage?[0].data["BRAKESDAMAGE"]?[2], 0)
        XCTAssertEqual(cardamage?[0].data["BRAKESDAMAGE"]?[3], 0)
        XCTAssertEqual(cardamage?[0].data["FRONTLEFTWINGDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["FRONTRIGHTWINGDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["REARWINGDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["FLOORDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["DIFFUSERDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["SIDEPODDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["DRSFAULT"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["GEARBOXDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["ENGINEDAMAGE"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["ENGINEMGUHWEAR"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["ENGINEESWEAR"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["ENGINECEWEAR"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["ENGINEICEWEAR"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["ENGINEMGUKWEAR"]?.first!, 0)
        XCTAssertEqual(cardamage?[0].data["ENGINETCWEAR"]?.first!, 0)
    }

    func testTelemetryCarSetup() throws {
        
        var data = getDataFromTest(vector: "car_setup")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 5)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 8)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 5)
        
        let carSetup = packet?.data["CARSETUP"]
        
        XCTAssertEqual(carSetup?[0].data["FRONTWING"]?[0], 8)
        XCTAssertEqual(carSetup?[0].data["REARWING"]?[0], 8)
        XCTAssertEqual(carSetup?[0].data["ONTHROTTLE"]?[0], 75)
        XCTAssertEqual(carSetup?[0].data["OFFTHROTTLE"]?[0], 75)
        XCTAssertEqual(carSetup?[0].data["FRONTCAMBER"]?[0], -3)
        XCTAssertEqual(carSetup?[0].data["REARCAMBER"]?[0], -1.2000000476837158)
        XCTAssertEqual(carSetup?[0].data["FRONTTOE"]?[0], 0.090000003576278687)
        XCTAssertEqual(carSetup?[0].data["REARTOE"]?[0], 0.4100000262260437)
        XCTAssertEqual(carSetup?[0].data["FRONTSUSPENSION"]?[0], 8)
        XCTAssertEqual(carSetup?[0].data["REARSUSPENSION"]?[0], 2)
        XCTAssertEqual(carSetup?[0].data["FRONTANTIROLLBAR"]?[0], 8)
        XCTAssertEqual(carSetup?[0].data["REARANTIROLLBAR"]?[0], 1)
        XCTAssertEqual(carSetup?[0].data["FRONTSUSPENSIONHEIGHT"]?.first!, 3)
        XCTAssertEqual(carSetup?[0].data["REARSUSPENSIONHEIGHT"]?.first!, 7)
        XCTAssertEqual(carSetup?[0].data["BRAKEPRESSURE"]?.first!, 95)
        XCTAssertEqual(carSetup?[0].data["BRAKEBIAS"]?.first!, 58)
        XCTAssertEqual(carSetup?[0].data["REARLEFTTYREPRESSURE"]?.first!, 23.100000381469727)
        XCTAssertEqual(carSetup?[0].data["REARRIGHTTYREPRESSURE"]?.first!, 23.100000381469727)
        XCTAssertEqual(carSetup?[0].data["FRONTLEFTTYREPRESSURE"]?.first!, 22.200000762939453)
        XCTAssertEqual(carSetup?[0].data["FRONTRIGHTTYREPRESSURE"]?.first!, 22.200000762939453)
        XCTAssertEqual(carSetup?[0].data["BALLAST"]?.first!, 6)
        XCTAssertEqual(carSetup?[0].data["FUELLOAD"]?.first!, 20)
    }
    
    func testCarStatus() throws {
        var data = getDataFromTest(vector: "car_status")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
    
        XCTAssertEqual(packet?.getPacketType(), 7)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 5)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 7)
        
        let carStatus = packet?.data["CARSTATUS"]
        
        XCTAssertEqual(carStatus?[0].data["TRACTIONCONTROL"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["ANTILOCKBRAKES"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["FUELMIX"]?[0], 3)
        XCTAssertEqual(carStatus?[0].data["FRONTBRAKEBIAS"]?[0], 58)
        XCTAssertEqual(carStatus?[0].data["PITLIMITERSTATUS"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["FUELINTANK"]?[0], 10)
        XCTAssertEqual(carStatus?[0].data["FUELCAPACITY"]?[0], 110)
        XCTAssertEqual(carStatus?[0].data["FUELREMAININGLAPS"]?[0], 5.4395599365234375)
        XCTAssertEqual(carStatus?[0].data["MAXRPM"]?[0], 13000)
        XCTAssertEqual(carStatus?[0].data["IDLERPM"]?[0], 3499)
        XCTAssertEqual(carStatus?[0].data["MAXGEARS"]?[0], 9)
        XCTAssertEqual(carStatus?[0].data["DRSALLOWED"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["DRSACTIVATIONDISTANCE"]?[0], 144)
        XCTAssertEqual(carStatus?[0].data["ACTUALTYRECOMPOUND"]?[0], 17)
        XCTAssertEqual(carStatus?[0].data["VISUALTYRECOMPOUND"]?[0], 16)
        XCTAssertEqual(carStatus?[0].data["TYRESAGELAPS"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["VEHICLEFIAFLAGS"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["ERSSTOREENERGY"]?[0], 4000000)
        XCTAssertEqual(carStatus?[0].data["ERSDEPLOYMODE"]?[0], 2)
        XCTAssertEqual(carStatus?[0].data["ERSHARVESTEDTHISLAPMGUK"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["ERSHARVESTEDTHISLAPMGUH"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["ERSDEPLOYEDTHISLAP"]?[0], 0)
        XCTAssertEqual(carStatus?[0].data["NETWORKPAUSED"]?[0], 0)
    }

    func testTelemetryCarData() throws {
        
        var data = getDataFromTest(vector: "car_telemetry")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 6)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 5)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 6)
        
        let carTelemetry = packet?.data["CARTELEMERTY"]
        
        XCTAssertEqual(carTelemetry?[0].data["SPEED"]?[0], 253)
        XCTAssertEqual(carTelemetry?[0].data["THROTTLE"]?[0], 1)
        XCTAssertEqual(carTelemetry?[0].data["STEER"]?[0], -0.37254893779754639)
        XCTAssertEqual(carTelemetry?[0].data["BRAKE"]?[0], 0)
        XCTAssertEqual(carTelemetry?[0].data["CLUTCH"]?[0], 0)
        XCTAssertEqual(carTelemetry?[0].data["GEAR"]?[0], 6)
        XCTAssertEqual(carTelemetry?[0].data["ENGINERPM"]?[0], 11600)
        XCTAssertEqual(carTelemetry?[0].data["DRS"]?[0], 0)
        XCTAssertEqual(carTelemetry?[0].data["REVLIGHTSPERCENT"]?[0], 68)
        XCTAssertEqual(carTelemetry?[0].data["REVLIGHTSBITVALUE"]?[0], 2047)
        XCTAssertEqual(carTelemetry?[0].data["BRAKESTEMPERATURE"]?[0], 29)
        XCTAssertEqual(carTelemetry?[0].data["BRAKESTEMPERATURE"]?[1], 29)
        XCTAssertEqual(carTelemetry?[0].data["BRAKESTEMPERATURE"]?[2], 29)
        XCTAssertEqual(carTelemetry?[0].data["BRAKESTEMPERATURE"]?[3], 29)
        XCTAssertEqual(carTelemetry?[0].data["TYRESSURFACETEMPERATURE"]?[0], 100)
        XCTAssertEqual(carTelemetry?[0].data["TYRESSURFACETEMPERATURE"]?[1], 100)
        XCTAssertEqual(carTelemetry?[0].data["TYRESSURFACETEMPERATURE"]?[2], 100)
        XCTAssertEqual(carTelemetry?[0].data["TYRESSURFACETEMPERATURE"]?[3], 100)
        XCTAssertEqual(carTelemetry?[0].data["TYRESINNERTEMPERATURE"]?[0], 100)
        XCTAssertEqual(carTelemetry?[0].data["TYRESINNERTEMPERATURE"]?[1], 100)
        XCTAssertEqual(carTelemetry?[0].data["TYRESINNERTEMPERATURE"]?[2], 100)
        XCTAssertEqual(carTelemetry?[0].data["TYRESINNERTEMPERATURE"]?[3], 100)
        XCTAssertEqual(carTelemetry?[0].data["ENGINETEMPERATURE"]?[0], 90)
        XCTAssertEqual(carTelemetry?[0].data["TYRESPRESSURE"]?[0], 23.573812484741211)
        XCTAssertEqual(carTelemetry?[0].data["TYRESPRESSURE"]?[1], 23.573812484741211)
        XCTAssertEqual(carTelemetry?[0].data["TYRESPRESSURE"]?[2], 22.655353546142578)
        XCTAssertEqual(carTelemetry?[0].data["TYRESPRESSURE"]?[3], 22.655353546142578)
        XCTAssertEqual(carTelemetry?[0].data["SURFACETYPE"]?[0], 0)
        XCTAssertEqual(carTelemetry?[0].data["SURFACETYPE"]?[1], 0)
        XCTAssertEqual(carTelemetry?[0].data["SURFACETYPE"]?[2], 0)
        XCTAssertEqual(carTelemetry?[0].data["SURFACETYPE"]?[3], 0)

        let carTelemetryData = packet?.data["CARTELEMERTYDATA"]
        
        XCTAssertEqual(carTelemetryData?[0].data["MFDPANELINDEX"]?[0], 255)
        XCTAssertEqual(carTelemetryData?[0].data["MFDPANELINDEXSECONDARYPLAYER"]?[0], 255)
        XCTAssertEqual(carTelemetryData?[0].data["SUGGESTEDGEAR"]?[0], 0)
    }

    func testTelemetrySpeedTrapEvent() throws {
        
        var data = getDataFromTest(vector: "event_sptp")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 3)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 8)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 3)
        
        let eventstring = packet?.data["EVENTSTRING"]
        
        XCTAssertEqual(eventstring?[0].data["EVENTSTRINGCODE"]?.toString(), "SPTP")
        
        let speedTrap = packet?.data["SPEEDTRAP"]
        
        XCTAssertEqual(speedTrap?[0].data["VEHICLEIDX"]?[0], 17)
        XCTAssertEqual(speedTrap?[0].data["SPEED"]?[0], 307.86004638671875)
        XCTAssertEqual(speedTrap?[0].data["OVERALLFASTESTINSESSION"]?[0], 0)
        XCTAssertEqual(speedTrap?[0].data["DRIVERFASTESTINSESSION"]?[0], 0)
    }
 
    func testFinalClassification() throws {
        
        var data = getDataFromTest(vector: "event_sptp")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 3)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 8)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 3)
        
        let eventstring = packet?.data["EVENTSTRING"]
        
        XCTAssertEqual(eventstring?[0].data["EVENTSTRINGCODE"]?.toString(), "SPTP")
        
        let speedTrap = packet?.data["SPEEDTRAP"]
        
        XCTAssertEqual(speedTrap?[0].data["VEHICLEIDX"]?[0], 17)
        XCTAssertEqual(speedTrap?[0].data["SPEED"]?[0], 307.86004638671875)
        XCTAssertEqual(speedTrap?[0].data["OVERALLFASTESTINSESSION"]?[0], 0)
        XCTAssertEqual(speedTrap?[0].data["DRIVERFASTESTINSESSION"]?[0], 0)
    }

    func testLapData() throws {
        
        var data = getDataFromTest(vector: "lap_data")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 2)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 7)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 2)
        
        let lapdata = packet?.data["LAPDATA"]
        
        XCTAssertEqual(lapdata?[0].data["LASTLAPTIMEINMS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["CURRENTLAPTIMEINMS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["SECTOR1TIMEINMS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["SECTOR2TIMEINMS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["LAPDISTANCE"]?[0], -5456.56787109375)
        XCTAssertEqual(lapdata?[0].data["TOTALDISTANCE"]?[0], -5456.56787109375)
        XCTAssertEqual(lapdata?[0].data["SAFETYCARDELTA"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["CARPOSITION"]?[0], 8)
        XCTAssertEqual(lapdata?[0].data["CURRENTLAPNUM"]?[0], 1)
        XCTAssertEqual(lapdata?[0].data["PITSTATUS"]?[0], 1)
        XCTAssertEqual(lapdata?[0].data["NUMPITSTOPS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["SECTOR"]?[0], 2)
        XCTAssertEqual(lapdata?[0].data["CURRENTLAPINVALID"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["PENALTIES"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["WARNINGS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["NUMUNSERVEDDRIVETHROUGHPENS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["NUMUNSERVEDSTOPGOPENS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["GRIDPOSITION"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["DRIVERSTATUS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["RESULTSTATUS"]?[0], 2)
        XCTAssertEqual(lapdata?[0].data["PITLANETIMERACTIVE"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["PITLANETIMEINLANEINMS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["PITSTOPTIMERINMS"]?[0], 0)
        XCTAssertEqual(lapdata?[0].data["PITSTOPSHOULDSERVEPEN"]?[0], 0)
    }
    
    func testMotionData() throws {
        
        var data = getDataFromTest(vector: "motion_data")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 0)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 8)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 0)
        
        let carMotion = packet?.data["CARMOTIONDATA"]
        
        XCTAssertEqual(carMotion?[0].data["WORLDPOSITIONX"]?[0], 22.669370651245117)
        XCTAssertEqual(carMotion?[0].data["WORLDPOSITIONY"]?[0], 3.3167672157287598)
        XCTAssertEqual(carMotion?[0].data["WORLDPOSITIONZ"]?[0], 552.17596435546875)
        XCTAssertEqual(carMotion?[0].data["WORLDVELOCITYX"]?[0], 0)
        XCTAssertEqual(carMotion?[0].data["WORLDVELOCITYY"]?[0], 0)
        XCTAssertEqual(carMotion?[0].data["WORLDVELOCITYZ"]?[0], 0)
        XCTAssertEqual(carMotion?[0].data["WORLDFORWARDDIRX"]?[0], -22788)
        XCTAssertEqual(carMotion?[0].data["WORLDFORWARDDIRY"]?[0], -287)
        XCTAssertEqual(carMotion?[0].data["WORLDFORWARDDIRZ"]?[0], 23542)
        XCTAssertEqual(carMotion?[0].data["WORLDRIGHTDIRX"]?[0], -23543)
        XCTAssertEqual(carMotion?[0].data["WORLDRIGHTDIRY"]?[0], 0)
        XCTAssertEqual(carMotion?[0].data["WORLDRIGHTDIRZ"]?[0], -22789)
        XCTAssertEqual(carMotion?[0].data["GFORCELATERAL"]?[0], 0)
        XCTAssertEqual(carMotion?[0].data["GFORCELONGITUDINAL"]?[0], 0)
        XCTAssertEqual(carMotion?[0].data["GFORCEVERTICAL"]?[0], 0)
        XCTAssertEqual(carMotion?[0].data["YAW"]?[0], -0.76910978555679321)
        XCTAssertEqual(carMotion?[0].data["PITCH"]?[0], -0.006103533785790205)
        XCTAssertEqual(carMotion?[0].data["ROLL"]?[0], -1.2873906598542817e-05)

        let motion = packet?.data["MOTIONDATA"]
                       
        XCTAssertEqual(motion?[0].data["SUSPENSIONPOSITION"]?[0], 1.6951656341552734)
        XCTAssertEqual(motion?[0].data["SUSPENSIONPOSITION"]?[1], 1.9155979156494141)
        XCTAssertEqual(motion?[0].data["SUSPENSIONPOSITION"]?[2], 9.24957275390625)
        XCTAssertEqual(motion?[0].data["SUSPENSIONPOSITION"]?[3], 9.1767473220825195)
        XCTAssertEqual(motion?[0].data["SUSPENSIONVELOCITY"]?[0], 31.996639251708984)
        XCTAssertEqual(motion?[0].data["SUSPENSIONVELOCITY"]?[1], 32.093448638916016)
        XCTAssertEqual(motion?[0].data["SUSPENSIONVELOCITY"]?[2], 6.7265887260437012)
        XCTAssertEqual(motion?[0].data["SUSPENSIONVELOCITY"]?[3], 5.0883455276489258)
        XCTAssertEqual(motion?[0].data["WHEELSPEED"]?[0], 70.440185546875)
        XCTAssertEqual(motion?[0].data["WHEELSPEED"]?[1], 70.448707580566406)
        XCTAssertEqual(motion?[0].data["WHEELSPEED"]?[2], 70.060035705566406)
        XCTAssertEqual(motion?[0].data["WHEELSPEED"]?[3], 70.064498901367188)
        XCTAssertEqual(motion?[0].data["WHEELSLIP"]?[0], 0.0058781877160072327)
        XCTAssertEqual(motion?[0].data["WHEELSLIP"]?[1], 0.0059530939906835556)
        XCTAssertEqual(motion?[0].data["WHEELSLIP"]?[2], 0.00042044464498758316)
        XCTAssertEqual(motion?[0].data["WHEELSLIP"]?[3], 0.00043327902676537633)
        XCTAssertEqual(motion?[0].data["LOCALVELOCITYX"]?[0], -0.0067737055942416191)
        XCTAssertEqual(motion?[0].data["LOCALVELOCITYY"]?[0], -0.14525362849235535)
        XCTAssertEqual(motion?[0].data["LOCALVELOCITYZ"]?[0], 70.032707214355469)
        XCTAssertEqual(motion?[0].data["ANGULARVELOCITYX"]?[0], 0.00016996217891573906)
        XCTAssertEqual(motion?[0].data["ANGULARVELOCITYY"]?[0], 0.0022311185020953417)
        XCTAssertEqual(motion?[0].data["ANGULARVELOCITYZ"]?[0], -0.015569943934679031)
        XCTAssertEqual(motion?[0].data["ANGULARACCELERATIONX"]?[0], -0.31259262561798096)
        XCTAssertEqual(motion?[0].data["ANGULARACCELERATIONY"]?[0], 0.0033809468150138855)
        XCTAssertEqual(motion?[0].data["ANGULARACCELERATIONZ"]?[0], -0.10543192178010941)
        XCTAssertEqual(motion?[0].data["FRONTWHEELSANGLE"]?[0], 0)
    }

    func testParticipantsData() throws {
        
        var data = getDataFromTest(vector: "participant_data")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 4)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 8)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 4)
        
        let activeCars = packet?.data["ACTIVECARS"]
        
        XCTAssertEqual(activeCars?[0].data["NUMACTIVECARS"]?[0], 20)

        let participant = packet?.data["PARTICIPANTDATA"]
                       
        XCTAssertEqual(participant?[0].data["AICONTROLLED"]?[0], 1)
        XCTAssertEqual(participant?[0].data["DRIVERID"]?[0], 14)
        XCTAssertEqual(participant?[0].data["NETWORKID"]?[0], 255)
        XCTAssertEqual(participant?[0].data["TEAMID"]?[0], 2)
        XCTAssertEqual(participant?[0].data["MYTEAM"]?[0], 0)
        XCTAssertEqual(participant?[0].data["RACENUMBER"]?[0], 11)
        XCTAssertEqual(participant?[0].data["NATIONALITY"]?[0], 52)
        XCTAssertEqual(participant?[0].data["NAME"]?.toString(), "PEREZ")
        XCTAssertEqual(participant?[0].data["YOURTELEMETRY"]?[0], 1)
    }
    
    func testSessionData() throws {
        
        var data = getDataFromTest(vector: "session_packet")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 1)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 6)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 1)
        
        let marshalZone = packet?.data["MARSHALZONE"]
        
        XCTAssertEqual(marshalZone?[0].data["ZONESTART"]?[0], 0.0024357740767300129)
        XCTAssertEqual(marshalZone?[0].data["ZONEFLAG"]?[0], 0)
        
        let weatherForcastSample = packet?.data["WEATHERFORECASTSAMPLE"]
   
        XCTAssertEqual(weatherForcastSample?[0].data["SESSIONTYPE"]?[0], 0)
        XCTAssertEqual(weatherForcastSample?[0].data["TIMEOFFSET"]?[0], 0)
        XCTAssertEqual(weatherForcastSample?[0].data["WEATHER"]?[0], 0)
        XCTAssertEqual(weatherForcastSample?[0].data["TRACKTEMPERATURE"]?[0], 0)
        XCTAssertEqual(weatherForcastSample?[0].data["TRACKTEMPERATURECHANGE"]?[0], 0)
        XCTAssertEqual(weatherForcastSample?[0].data["AIRTEMPERATURE"]?[0], 0)
        XCTAssertEqual(weatherForcastSample?[0].data["AIRTEMPERATURECHANGE"]?[0], 0)
        XCTAssertEqual(weatherForcastSample?[0].data["RAINPERCENTAGE"]?[0], 0)
        
        let sessionData = packet?.data["SESSIONDATA"]
        
        XCTAssertEqual(sessionData?[0].data["WEATHER"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["TRACKTEMPERATURE"]?[0], 32)
        XCTAssertEqual(sessionData?[0].data["AIRTEMPERATURE"]?[0], 24)
        XCTAssertEqual(sessionData?[0].data["TOTALLAPS"]?[0], 200)
        XCTAssertEqual(sessionData?[0].data["TRACKLENGTH"]?[0], 5301)
        XCTAssertEqual(sessionData?[0].data["SESSIONTYPE"]?[0], 13)
        XCTAssertEqual(sessionData?[0].data["TRACKID"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["FORMULA"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["SESSIONTIMELEFT"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["SESSIONDURATION"]?[0], 600)
        XCTAssertEqual(sessionData?[0].data["PITSPEEDLIMIT"]?[0], 60)
        XCTAssertEqual(sessionData?[0].data["GAMEPAUSED"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["ISSPECTATING"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["SPECTATORCARINDEX"]?[0], 255)
        XCTAssertEqual(sessionData?[0].data["SLIPRONATIVESUPPORT"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["NUMMARSHALZONES"]?[0], 20)
        XCTAssertEqual(sessionData?[0].data["SAFETYCARSTATUS"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["NETWORKGAME"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["NUMWEATHERFORECASTSAMPLES"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["FORECASTACCURACY"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["AIDIFFICULTY"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["SEASONLINKIDENTIFIER"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["WEEKENDLINKIDENTIFIER"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["SEASONLINKIDENTIFIER"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["PITSTOPWINDOWIDEALLAP"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["PITSTOPWINDOWLATESTLAP"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["PITSTOPREJOINPOSITION"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["STEERINGASSIST"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["BRAKINGASSIST"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["GEARBOXASSIST"]?[0], 1)
        XCTAssertEqual(sessionData?[0].data["PITASSIST"]?[0], 1)
        XCTAssertEqual(sessionData?[0].data["PITRELEASEASSIST"]?[0], 1)
        XCTAssertEqual(sessionData?[0].data["ERSASSIST"]?[0], 1)
        XCTAssertEqual(sessionData?[0].data["DRSASSIST"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["DYNAMICRACINGLINE"]?[0], 0)
        XCTAssertEqual(sessionData?[0].data["DYNAMICRACINGLINETYPE"]?[0], 0)
    }

    func testSessionHistory() throws {
        
        var data = getDataFromTest(vector: "history_packet")

        let creator = TelemetryF12021PacketCreator()
        let packet = creator.create(from: &data)
        
        XCTAssertEqual(packet?.getPacketType(), 11)
        
        let header = packet?.data["PACKETHEADER"]
        
        XCTAssertEqual(header?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["GAMEMINORVERSION"]?.first!, 6)
        XCTAssertEqual(header?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header?.first!.data["PACKETID"]?.first!, 11)
        
        let lapHistory = packet?.data["LAPHISTORYDATA"]
        
        XCTAssertEqual(lapHistory?.first!.data["LAPTIMEINMS"]?.first!, 0)
        XCTAssertEqual(lapHistory?.first!.data["SECTOR1TIMEINMS"]?.first!, 0)
        XCTAssertEqual(lapHistory?.first!.data["SECTOR2TIMEINMS"]?.first!, 0)
        XCTAssertEqual(lapHistory?.first!.data["SECTOR3TIMEINMS"]?.first!, 0)
        XCTAssert(lapHistory?.first!.data["LAPVALIDBITFLAGS"]?.and(at: 0, with: 0x01) != nil)
        XCTAssert(lapHistory?.first!.data["LAPVALIDBITFLAGS"]?.and(at: 0, with: 0x02) != nil)
        XCTAssert(lapHistory?.first!.data["LAPVALIDBITFLAGS"]?.and(at: 0, with: 0x04) != nil)
        XCTAssert(lapHistory?.first!.data["LAPVALIDBITFLAGS"]?.and(at: 0, with: 0x08) != nil)
        
        let tyreStintHistory = packet?.data["TYRESTINTHISTORYDATA"]
    
        XCTAssertEqual(tyreStintHistory?.first!.data["ENDLAP"]?.first!, 255)
        XCTAssertEqual(tyreStintHistory?.first!.data["TYREACTUALCOMPOUND"]?.first!, 19)
        XCTAssertEqual(tyreStintHistory?.first!.data["TYREVISUALCOMPOUND"]?.first!, 18)
        
        let sessionHistoryData = packet?.data["SESSIONHISTORYDATA"]
        
        XCTAssertEqual(sessionHistoryData?.first!.data["CARIDX"]?.first!, 10)
        XCTAssertEqual(sessionHistoryData?.first!.data["NUMLAPS"]?.first!, 1)
        XCTAssertEqual(sessionHistoryData?.first!.data["NUMTYRESTINTS"]?.first!, 1)
        XCTAssertEqual(sessionHistoryData?.first!.data["BESTLAPTIMELAPNUM"]?.first!, 0)
        XCTAssertEqual(sessionHistoryData?.first!.data["BESTSECTOR1LAPNUM"]?.first!, 0)
        XCTAssertEqual(sessionHistoryData?.first!.data["BESTSECTOR2LAPNUM"]?.first!, 0)
        XCTAssertEqual(sessionHistoryData?.first!.data["BESTSECTOR3LAPNUM"]?.first!, 0)
    }
    
    func testFileReader() throws {
        
        let reader = TestFileReader(vector: "telemetry")
        guard let packet = reader.read(amount: 2048) else {
            XCTAssert(false)
            return
        }
        
        var iter = packet.makeIterator()
        
        var header = try TelemetryHeader(data: &iter)
        
        XCTAssertEqual(header.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header.data["GAMEMINORVERSION"]?.first!, 12)
        XCTAssertEqual(header.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header.data["PACKETID"]?.first!, 2)
        
        iter = packet.makeIterator()
        
        let lapdata = try TelemetryLapDataPacket(data: &iter)
        
        var headers = lapdata.data["PACKETHEADER"]
        
        XCTAssertEqual(headers?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(headers?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(headers?.first!.data["GAMEMINORVERSION"]?.first!, 12)
        XCTAssertEqual(headers?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(headers?.first!.data["PACKETID"]?.first!, 2)
        
        guard let packet = reader.read(amount: 2048) else {
            XCTAssert(false)
            return
        }
        
        iter = packet.makeIterator()
        
        header = try TelemetryHeader(data: &iter)
        
        XCTAssertEqual(header.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header.data["GAMEMINORVERSION"]?.first!, 12)
        XCTAssertEqual(header.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header.data["PACKETID"]?.first!, 0)
    
        iter = packet.makeIterator()
        
        let motion = try TelemetryMotionPacket(data: &iter)
        
        headers = motion.data["PACKETHEADER"]
        
        XCTAssertEqual(headers?.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(headers?.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(headers?.first!.data["GAMEMINORVERSION"]?.first!, 12)
        XCTAssertEqual(headers?.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(headers?.first!.data["PACKETID"]?.first!, 0)
    }
    
    func testCapturePacket() throws {
        
        let reader = TestFileReader(vector: "telemetry")
        let capture = try CaptureF12021Telemetry(reader: reader)
        
        guard let packet = capture.capturePacket() else {
            XCTAssert(false)
            return
        }
        
        guard let header = packet.data["PACKETHEADER"] else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(header.first!.data["PACKETFORMAT"]?.first!, 2021)
        XCTAssertEqual(header.first!.data["GAMEMAJORVERSION"]?.first!, 1)
        XCTAssertEqual(header.first!.data["GAMEMINORVERSION"]?.first!, 12)
        XCTAssertEqual(header.first!.data["PACKETVERSION"]?.first!, 1)
        XCTAssertEqual(header.first!.data["PACKETID"]?.first!, 2)
    }

    func testCapturePackets() throws {
        
        let reader = TestFileReader(vector: "telemetry")
        let capture = try CaptureF12021Telemetry(reader: reader)
        
        var count = 2001
        while count != 0 {
            count -= 1
            let packet = capture.capturePackets()
            if packet.frequency == "menu" {
                XCTAssertNotEqual(packet.telemetry.count, 0)
            }
            if packet.frequency == "twoSec" {
                XCTAssertNotEqual(packet.telemetry.count, 0)
            }
            if packet.frequency == "fiveSec" {
                XCTAssertNotEqual(packet.telemetry.count, 0)
            }
            if packet.frequency == "event" {
                XCTAssertNotEqual(packet.telemetry.count, 0)
            }
            if packet.frequency == "history" {
                XCTAssertNotEqual(packet.telemetry.count, 0)
            }
        }
        
        // XCTAssertEqual(packets.frequency, "menu")
    }
    
    
//    func testReader() throws {
//        let udp = try! UDPReader(listen: "20777")
//
//        var telemetry = Data()
//
//        var count = 65000 // roughly 20000 a lap
//
//        while count != 0 {
//            print("\(count)")
//            count -= 1
//            guard let data = udp.read(amount: 2048)?.base64EncodedData() else {
//                continue
//            }
//
//            telemetry.append(data)
//            telemetry.append(0x0A) // new
////            var iter = data.makeIterator()
////
////            let packet = try! TelemetryHeader(data: &iter)
////
////            print ("packet id \(String(describing: packet.data["PACKETID"]?.first))")
////            print ("frame  id \(String(describing: packet.data["FRAMEIDENTIFIER"]?.first))")
//
//        }
//
//        try! telemetry.write(to: URL(fileURLWithPath: "/Users/leighmclean/Tmp/telemetry.bin"))
//
//        let data = try String(contentsOfFile: "/Users/leighmclean/Tmp/telemetry.bin", encoding: .utf8)
//
//        var myStrings = data.components(separatedBy: .newlines)
//        _ = myStrings.popLast()
//
//        for d in myStrings {
//            guard var iter = Data(base64Encoded: d)?.makeIterator() else {
//                continue
//            }
//            let packet = try! TelemetryHeader(data: &iter)
//
//            print ("packet id \(String(describing: packet.data["PACKETID"]?.first))")
//            print ("frame  id \(String(describing: packet.data["FRAMEIDENTIFIER"]?.first))")
//        }
//
//    }
    

}

func getDataFromTest(vector: String) -> Data {
    return try! Data(contentsOf: URL(fileURLWithPath: Bundle.module.path(forResource: vector, ofType: "bin")!))
}

class TestFileReader: Reader {
    
    var base64Packets: [String]
    
    init(vector: String) {
        let data = getDataFromTest(vector: vector)
        guard let base64Data = String(data: data, encoding: .utf8) else {
            base64Packets = []
            return
        }
        
        base64Packets = base64Data.components(separatedBy: .newlines)
        _ = base64Packets.popLast() // remove the last packet because it is empty
    }
    
    func read(amount: Int) -> (Data?) {
        guard !base64Packets.isEmpty else {
            return nil
        }
        guard let packet = Data(base64Encoded: base64Packets.removeFirst()) else {
            return nil
        }
        
        return packet
    }
}
