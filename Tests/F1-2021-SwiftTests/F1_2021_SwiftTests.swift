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
    
    func getDataFromTest(vector: String) -> Data {
        return try! Data(contentsOf: URL(fileURLWithPath: Bundle.module.path(forResource: vector, ofType: "bin")!))
    }
}
