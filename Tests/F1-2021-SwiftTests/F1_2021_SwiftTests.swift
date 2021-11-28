import XCTest
@testable import F1_2021_Swift

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
        
        XCTAssertEqual(try! header?.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.getTelemetryData(by: "GAMEMINORVERSION").first!, 4)
        XCTAssertEqual(try! header?.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.getTelemetryData(by: "PACKETID").first!, 3)
        XCTAssertEqual(try! header?.getTelemetryData(by: "SESSIONUID").first!, 2741612942)
        XCTAssertEqual(try! header?.getTelemetryData(by: "SESSIONTIME").first!, 80.485137939453125)
        XCTAssertEqual(try! header?.getTelemetryData(by: "FRAMEIDENTIFIER").first!, 1684)
        XCTAssertEqual(try! header?.getTelemetryData(by: "PLAYERCARINDEX").first!, 0)
        XCTAssertEqual(try! header?.getTelemetryData(by: "SECONDARYPLAYERCARINDEX").first!, 255)

    }
    
    func testTelemetryCarDamage() throws {
        
        let data = getDataFromTest(vector: "car_damage")

        var iter = data.makeIterator()
        let packet = try? TelemetryCarDamagePacket(data: &iter)
        
        let header = try! packet?.getTelemetryData(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMINORVERSION").first!, 8)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETID").first!, 10)
        
        let cardamage = try! packet?.getTelemetryData(by: "CARDAMAGE")
        
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESWEAR")[0], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESWEAR")[1], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESWEAR")[2], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESWEAR")[3], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESDAMAGE")[0], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESDAMAGE")[1], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESDAMAGE")[2], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "TYRESDAMAGE")[3], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "BRAKESDAMAGE")[0], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "BRAKESDAMAGE")[1], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "BRAKESDAMAGE")[2], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "BRAKESDAMAGE")[3], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "FRONTLEFTWINGDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "FRONTRIGHTWINGDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "REARWINGDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "FLOORDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "DIFFUSERDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "SIDEPODDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "DRSFAULT").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "GEARBOXDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "ENGINEDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "ENGINEMGUHWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "ENGINEESWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "ENGINECEWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "ENGINEICEWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "ENGINEMGUKWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetryData(by: "ENGINETCWEAR").first!, 0)
    }

    func testTelemetryCarSetup() throws {
        
        let data = getDataFromTest(vector: "car_setup")

        var iter = data.makeIterator()
        let packet = try? TelemetryCarSetupPacket(data: &iter)
        
        let header = try! packet?.getTelemetryData(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMINORVERSION").first!, 8)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETID").first!, 5)
        
        let carSetup = try! packet?.getTelemetryData(by: "CARSETUP")
        
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTWING")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARWING")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "ONTHROTTLE")[0], 75)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "OFFTHROTTLE")[0], 75)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTCAMBER")[0], -3)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARCAMBER")[0], -1.2000000476837158)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTTOE")[0], 0.090000003576278687)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARTOE")[0], 0.4100000262260437)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTSUSPENSION")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARSUSPENSION")[0], 2)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTANTIROLLBAR")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARANTIROLLBAR")[0], 1)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTSUSPENSIONHEIGHT").first!, 3)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARSUSPENSIONHEIGHT").first!, 7)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "BRAKEPRESSURE").first!, 95)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "BRAKEBIAS").first!, 58)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARLEFTTYREPRESSURE").first!, 23.100000381469727)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "REARRIGHTTYREPRESSURE").first!, 23.100000381469727)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTLEFTTYREPRESSURE").first!, 22.200000762939453)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FRONTRIGHTTYREPRESSURE").first!, 22.200000762939453)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "BALLAST").first!, 6)
        XCTAssertEqual(try! carSetup?[0].getTelemetryData(by: "FUELLOAD").first!, 20)
    }

    func testTelemetryCarData() throws {
        
        let data = getDataFromTest(vector: "car_telemetry")

        var iter = data.makeIterator()
        let packet = try? TelemetryCarPacket(data: &iter)
        
        let header = try! packet?.getTelemetryData(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMINORVERSION").first!, 5)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETID").first!, 6)
        
        let carTelemetry = try! packet?.getTelemetryData(by: "CARTELEMERTY")
        
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "SPEED")[0], 253)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "THROTTLE")[0], 1)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "STEER")[0], -0.37254893779754639)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "BRAKE")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "CLUTCH")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "GEAR")[0], 6)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "ENGINERPM")[0], 11600)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "DRS")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "REVLIGHTSPERCENT")[0], 68)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "REVLIGHTSBITVALUE")[0], 2047)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "BRAKESTEMPERATURE")[0], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "BRAKESTEMPERATURE")[1], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "BRAKESTEMPERATURE")[2], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "BRAKESTEMPERATURE")[3], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESSURFACETEMPERATURE")[0], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESSURFACETEMPERATURE")[1], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESSURFACETEMPERATURE")[2], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESSURFACETEMPERATURE")[3], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESINNERTEMPERATURE")[0], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESINNERTEMPERATURE")[1], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESINNERTEMPERATURE")[2], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESINNERTEMPERATURE")[3], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "ENGINETEMPERATURE")[0], 90)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESPRESSURE")[0], 23.573812484741211)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESPRESSURE")[1], 23.573812484741211)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESPRESSURE")[2], 22.655353546142578)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "TYRESPRESSURE")[3], 22.655353546142578)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "SURFACETYPE")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "SURFACETYPE")[1], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "SURFACETYPE")[2], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetryData(by: "SURFACETYPE")[3], 0)

        let carTelemetryData = try! packet?.getTelemetryData(by: "CARTELEMERTYDATA")
        
        XCTAssertEqual(try! carTelemetryData?[0].getTelemetryData(by: "MFDPANELINDEX")[0], 255)
        XCTAssertEqual(try! carTelemetryData?[0].getTelemetryData(by: "MFDPANELINDEXSECONDARYPLAYER")[0], 255)
        XCTAssertEqual(try! carTelemetryData?[0].getTelemetryData(by: "SUGGESTEDGEAR")[0], 0)
    }

    func testTelemetrySpeedTrapEvent() throws {
        
        let data = getDataFromTest(vector: "event_sptp")

        var iter = data.makeIterator()
        let packet = try? TelemetryEventPacket(data: &iter)
        
        let header = try! packet?.getTelemetryData(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMINORVERSION").first!, 8)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETID").first!, 3)
        
        let eventstring = try! packet?.getTelemetryData(by: "EVENTSTRING")
        
        XCTAssertEqual(try! eventstring?[0].getTelemetryData(by: "EVENTSTRINGCODE").toString(), "SPTP")
        
        let speedTrap = try! packet?.getTelemetryData(by: "SPEEDTRAP")
        
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "VEHICLEIDX")[0], 17)
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "SPEED")[0], 307.86004638671875)
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "OVERALLFASTESTINSESSION")[0], 0)
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "DRIVERFASTESTINSESSION")[0], 0)
    }
 
    func testFinalClassification() throws {
        
        let data = getDataFromTest(vector: "event_sptp")

        var iter = data.makeIterator()
        let packet = try? TelemetryEventPacket(data: &iter)
        
        let header = try! packet?.getTelemetryData(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMINORVERSION").first!, 8)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETID").first!, 3)
        
        let eventstring = try! packet?.getTelemetryData(by: "EVENTSTRING")
        
        XCTAssertEqual(try! eventstring?[0].getTelemetryData(by: "EVENTSTRINGCODE").toString(), "SPTP")
        
        let speedTrap = try! packet?.getTelemetryData(by: "SPEEDTRAP")
        
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "VEHICLEIDX")[0], 17)
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "SPEED")[0], 307.86004638671875)
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "OVERALLFASTESTINSESSION")[0], 0)
        XCTAssertEqual(try! speedTrap?[0].getTelemetryData(by: "DRIVERFASTESTINSESSION")[0], 0)
    }

    func testLapData() throws {
        
        let data = getDataFromTest(vector: "lap_data")

        var iter = data.makeIterator()
        let packet = try? TelemetryLapDataPacket(data: &iter)
        
        let header = try! packet?.getTelemetryData(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMINORVERSION").first!, 7)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETID").first!, 2)
        
        let lapdata = try! packet?.getTelemetryData(by: "LAPDATA")
        
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "LASTLAPTIMEINMS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "CURRENTLAPTIMEINMS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "SECTOR1TIMEINMS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "SECTOR2TIMEINMS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "LAPDISTANCE")[0], -5456.56787109375)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "TOTALDISTANCE")[0], -5456.56787109375)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "SAFETYCARDELTA")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "CARPOSITION")[0], 8)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "CURRENTLAPNUM")[0], 1)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "PITSTATUS")[0], 1)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "NUMPITSTOPS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "SECTOR")[0], 2)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "CURRENTLAPINVALID")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "PENALTIES")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "WARNINGS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "NUMUNSERVEDDRIVETHROUGHPENS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "NUMUNSERVEDSTOPGOPENS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "GRIDPOSITION")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "DRIVERSTATUS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "RESULTSTATUS")[0], 2)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "PITLANETIMERACTIVE")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "PITLANETIMEINLANEINMS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "PITSTOPTIMERINMS")[0], 0)
        XCTAssertEqual(try! lapdata?[0].getTelemetryData(by: "PITSTOPSHOULDSERVEPEN")[0], 0)
    }
    
    func testMotionData() throws {
        
        let data = getDataFromTest(vector: "motion_data")

        var iter = data.makeIterator()
        let packet = try? TelemetryMotionPacket(data: &iter)
        
        let header = try! packet?.getTelemetryData(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "GAMEMINORVERSION").first!, 8)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetryData(by: "PACKETID").first!, 0)
        
        let carMotion = try! packet?.getTelemetryData(by: "CARMOTIONDATA")
        
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDPOSITIONX")[0], 22.669370651245117)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDPOSITIONY")[0], 3.3167672157287598)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDPOSITIONZ")[0], 552.17596435546875)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDVELOCITYX")[0], 0)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDVELOCITYY")[0], 0)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDVELOCITYZ")[0], 0)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDFORWARDDIRX")[0], -22788)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDFORWARDDIRY")[0], -287)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDFORWARDDIRZ")[0], 23542)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDRIGHTDIRX")[0], -23543)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDRIGHTDIRY")[0], 0)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "WORLDRIGHTDIRZ")[0], -22789)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "GFORCELATERAL")[0], 0)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "GFORCELONGITUDINAL")[0], 0)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "GFORCEVERTICAL")[0], 0)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "YAW")[0], -0.76910978555679321)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "PITCH")[0], -0.006103533785790205)
        XCTAssertEqual(try! carMotion?[0].getTelemetryData(by: "ROLL")[0], -1.2873906598542817e-05)

        let motion = try! packet?.getTelemetryData(by: "MOTIONDATA")
                       
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONPOSITION")[0], 1.6951656341552734)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONPOSITION")[1], 1.9155979156494141)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONPOSITION")[2], 9.24957275390625)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONPOSITION")[3], 9.1767473220825195)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONVELOCITY")[0], 31.996639251708984)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONVELOCITY")[1], 32.093448638916016)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONVELOCITY")[2], 6.7265887260437012)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "SUSPENSIONVELOCITY")[3], 5.0883455276489258)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSPEED")[0], 70.440185546875)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSPEED")[1], 70.448707580566406)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSPEED")[2], 70.060035705566406)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSPEED")[3], 70.064498901367188)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSLIP")[0], 0.0058781877160072327)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSLIP")[1], 0.0059530939906835556)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSLIP")[2], 0.00042044464498758316)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "WHEELSLIP")[3], 0.00043327902676537633)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "LOCALVELOCITYX")[0], -0.0067737055942416191)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "LOCALVELOCITYY")[0], -0.14525362849235535)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "LOCALVELOCITYZ")[0], 70.032707214355469)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "ANGULARVELOCITYX")[0], 0.00016996217891573906)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "ANGULARVELOCITYY")[0], 0.0022311185020953417)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "ANGULARVELOCITYZ")[0], -0.015569943934679031)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "ANGULARACCELERATIONX")[0], -0.31259262561798096)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "ANGULARACCELERATIONY")[0], 0.0033809468150138855)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "ANGULARACCELERATIONZ")[0], -0.10543192178010941)
        XCTAssertEqual(try! motion?[0].getTelemetryData(by: "FRONTWHEELSANGLE")[0], 0)
    }

    func getDataFromTest(vector: String) -> Data {
        return try! Data(contentsOf: URL(fileURLWithPath: Bundle.module.path(forResource: vector, ofType: "bin")!))
    }
}
