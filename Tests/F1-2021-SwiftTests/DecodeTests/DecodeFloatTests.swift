import XCTest
@testable import F1_2021_Swift

final class DecodeFloatTests: XCTestCase {
    func testDecodeFloat() throws {

        let decode = DecodeFloat<Float>()
        
        // Test we throw if we past the size of the data
        let empty = Data()
        var emptyIter = empty.makeIterator()
        
        XCTAssertThrowsError(try decode.data(from: &emptyIter), "An OutOfBounds error should have been thrown") { error in
            XCTAssertEqual(error as? DecodeError, DecodeError.OutOfBounds)
        }
        
        // Test we can decode four bytes
        
        let bytes: [UInt8] = [0x92,0xCB,0x8F,0xF0]
        let data = Data(bytes)
        var iter = data.makeIterator()
        
        XCTAssertEqual(try! decode.data(from: &iter).first!, -3.5601966249072491e+29)
    }
}
