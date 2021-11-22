//
//  File.swift
//  
//
//  Created by Leigh McLean on 22/11/21.
//

import Foundation

class Decode<T: Numeric> {
    
    public func data(amount : Int = 1, from iterator: inout Data.Iterator) throws -> [T] {
        return [T](arrayLiteral: try decode(from: &iterator))
    }
    
    private func decode(from iterator: inout Data.Iterator) throws -> T {
        
        var value = UInt32(try unwrap(iterator.next()))
        value |= UInt32(try unwrap(iterator.next())) << 8
        value |= UInt32(try unwrap(iterator.next())) << 16
        value |= UInt32(try unwrap(iterator.next())) << 24
        
        if T.self is Float.Type {
            return Float32(bitPattern: value) as! T
        }
        else {
            return Int(value) as! T
        }
    }
    
    private func unwrap(_ byte: UInt8?) throws -> UInt8 {
        return try byte ?? {throw DecodeError.OutOfBounds}()
    }
}
