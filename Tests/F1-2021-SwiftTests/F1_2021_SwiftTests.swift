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
        
        let eventPacket = getDataFromTest(vector: "event_packet.bin")

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
        
//        let eventPacket = getDataFromTest(vector: "car_damage.bin")
//
//        var iter = eventPacket.makeIterator()
//        let header = try? TelemetryCarDamage(data: &iter)
//
//        XCTAssertEqual(try! header?.getTelemetry(by: "PACKETFORMAT").first!, 2021)
//        XCTAssertEqual(try! header?.getTelemetry(by: "GAMEMAJORVERSION").first!, 1)
//        XCTAssertEqual(try! header?.getTelemetry(by: "GAMEMINORVERSION").first!, 4)
    }
    
    func getDataFromTest(vector: String) -> Data {
        return try! Data(contentsOf: URL(fileURLWithPath: "\(removeFileFromEndOfFilePath())testVectors/\(vector)"))
    }
    
    // could not find how to access the vectors through Resources?
    func removeFileFromEndOfFilePath() -> String {
        let endOfPath = #filePath.lastIndex(of: "/")!
        let path = #filePath[...endOfPath]
        return String(path)
    }
}
