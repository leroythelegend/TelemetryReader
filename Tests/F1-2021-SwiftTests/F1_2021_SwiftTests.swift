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
    
    func testTelemetryHeader() throws {
        
        let eventPacket = getDataFromTest(vector: "event_packet")

        var iter = eventPacket.makeIterator()
        let header = try? TelemetryHeader(data: &iter)
        
        XCTAssertEqual(try! header?.getTelemetry(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.getTelemetry(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.getTelemetry(by: "GAMEMINORVERSION").first!, 4)
        XCTAssertEqual(try! header?.getTelemetry(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.getTelemetry(by: "PACKETID").first!, 3)
        XCTAssertEqual(try! header?.getTelemetry(by: "SESSIONUID").first!, 2741612942)
        XCTAssertEqual(try! header?.getTelemetry(by: "SESSIONTIME").first!, 80.485137939453125)
        XCTAssertEqual(try! header?.getTelemetry(by: "FRAMEIDENTIFIER").first!, 1684)
        XCTAssertEqual(try! header?.getTelemetry(by: "PLAYERCARINDEX").first!, 0)
        XCTAssertEqual(try! header?.getTelemetry(by: "SECONDARYPLAYERCARINDEX").first!, 255)

    }
    
    func testTelemetryCarDamage() throws {
        
        let data = getDataFromTest(vector: "car_damage")

        var iter = data.makeIterator()
        let packet = try? TelemetryCarDamagePacket(data: &iter)
        
        let header = try! packet?.getTelemetryPackets(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "GAMEMINORVERSION").first!, 8)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETID").first!, 10)
        
        let cardamage = try! packet?.getTelemetryPackets(by: "CARDAMAGE")
        
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESWEAR")[0], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESWEAR")[1], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESWEAR")[2], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESWEAR")[3], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESDAMAGE")[0], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESDAMAGE")[1], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESDAMAGE")[2], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "TYRESDAMAGE")[3], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "BRAKESDAMAGE")[0], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "BRAKESDAMAGE")[1], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "BRAKESDAMAGE")[2], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "BRAKESDAMAGE")[3], 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "FRONTLEFTWINGDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "FRONTRIGHTWINGDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "REARWINGDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "FLOORDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "DIFFUSERDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "SIDEPODDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "DRSFAULT").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "GEARBOXDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "ENGINEDAMAGE").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "ENGINEMGUHWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "ENGINEESWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "ENGINECEWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "ENGINEICEWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "ENGINEMGUKWEAR").first!, 0)
        XCTAssertEqual(try! cardamage?[0].getTelemetry(by: "ENGINETCWEAR").first!, 0)
    }

    func testTelemetryCarSetup() throws {
        
        let data = getDataFromTest(vector: "car_setup")

        var iter = data.makeIterator()
        let packet = try? TelemetryCarSetupPacket(data: &iter)
        
        let header = try! packet?.getTelemetryPackets(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "GAMEMINORVERSION").first!, 8)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETID").first!, 5)
        
        let carSetup = try! packet?.getTelemetryPackets(by: "CARSETUP")
        
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTWING")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARWING")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "ONTHROTTLE")[0], 75)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "OFFTHROTTLE")[0], 75)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTCAMBER")[0], -3)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARCAMBER")[0], -1.2000000476837158)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTTOE")[0], 0.090000003576278687)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARTOE")[0], 0.4100000262260437)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTSUSPENSION")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARSUSPENSION")[0], 2)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTANTIROLLBAR")[0], 8)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARANTIROLLBAR")[0], 1)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTSUSPENSIONHEIGHT").first!, 3)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARSUSPENSIONHEIGHT").first!, 7)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "BRAKEPRESSURE").first!, 95)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "BRAKEBIAS").first!, 58)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARLEFTTYREPRESSURE").first!, 23.100000381469727)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "REARRIGHTTYREPRESSURE").first!, 23.100000381469727)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTLEFTTYREPRESSURE").first!, 22.200000762939453)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FRONTRIGHTTYREPRESSURE").first!, 22.200000762939453)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "BALLAST").first!, 6)
        XCTAssertEqual(try! carSetup?[0].getTelemetry(by: "FUELLOAD").first!, 20)
    }

    func testTelemetryCarData() throws {
        
        let data = getDataFromTest(vector: "car_telemetry")

        var iter = data.makeIterator()
        let packet = try? TelemetryCarPacket(data: &iter)
        
        let header = try! packet?.getTelemetryPackets(by: "PACKETHEADER")
        
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETFORMAT").first!, 2021)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "GAMEMAJORVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "GAMEMINORVERSION").first!, 5)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETVERSION").first!, 1)
        XCTAssertEqual(try! header?.first!.getTelemetry(by: "PACKETID").first!, 6)
        
        let carTelemetry = try! packet?.getTelemetryPackets(by: "CARTELEMERTY")
        
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "SPEED")[0], 253)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "THROTTLE")[0], 1)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "STEER")[0], -0.37254893779754639)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "BRAKE")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "CLUTCH")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "GEAR")[0], 6)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "ENGINERPM")[0], 11600)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "DRS")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "REVLIGHTSPERCENT")[0], 68)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "REVLIGHTSBITVALUE")[0], 2047)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "BRAKESTEMPERATURE")[0], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "BRAKESTEMPERATURE")[1], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "BRAKESTEMPERATURE")[2], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "BRAKESTEMPERATURE")[3], 29)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESSURFACETEMPERATURE")[0], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESSURFACETEMPERATURE")[1], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESSURFACETEMPERATURE")[2], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESSURFACETEMPERATURE")[3], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESINNERTEMPERATURE")[0], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESINNERTEMPERATURE")[1], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESINNERTEMPERATURE")[2], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESINNERTEMPERATURE")[3], 100)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "ENGINETEMPERATURE")[0], 90)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESPRESSURE")[0], 23.573812484741211)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESPRESSURE")[1], 23.573812484741211)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESPRESSURE")[2], 22.655353546142578)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "TYRESPRESSURE")[3], 22.655353546142578)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "SURFACETYPE")[0], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "SURFACETYPE")[1], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "SURFACETYPE")[2], 0)
        XCTAssertEqual(try! carTelemetry?[0].getTelemetry(by: "SURFACETYPE")[3], 0)

        let carTelemetryData = try! packet?.getTelemetryPackets(by: "CARTELEMERTYDATA")
        
        XCTAssertEqual(try! carTelemetryData?[0].getTelemetry(by: "MFDPANELINDEX")[0], 255)
        XCTAssertEqual(try! carTelemetryData?[0].getTelemetry(by: "MFDPANELINDEXSECONDARYPLAYER")[0], 255)
        XCTAssertEqual(try! carTelemetryData?[0].getTelemetry(by: "SUGGESTEDGEAR")[0], 0)
    }

    
    
    func getDataFromTest(vector: String) -> Data {
        return try! Data(contentsOf: URL(fileURLWithPath: Bundle.module.path(forResource: vector, ofType: "bin")!))
    }
}
