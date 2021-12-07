//
//  File.swift
//  
//
//  Created by Leigh McLean on 22/11/21.
//

import Foundation

class Decode<T: Numeric> {
 
    public func decode8Bytes(amount : Int = 1, from iterator: inout Data.Iterator) throws -> [Double] {
        
        var results: [Double] = []
        
        for _ in 1...amount {
            results.append(try convert8Bytes(from: &iterator))
        }
        
        return results
    }
    
    public func decode4Bytes(amount : Int = 1, from iterator: inout Data.Iterator) throws -> [Double] {
        
        var results: [Double] = []
        
        for _ in 1...amount {
            results.append(try convert4Bytes(from: &iterator))
        }
        
        return results
    }

    public func decode2Bytes(amount : Int = 1, from iterator: inout Data.Iterator) throws -> [Double] {
        
        var results: [Double] = []
        
        for _ in 1...amount {
            results.append(try convert2Bytes(from: &iterator))
        }
        
        return results
    }

    public func decodeByte(amount : Int = 1, from iterator: inout Data.Iterator) throws -> [Double] {
        
        var results: [Double] = []
        
        for _ in 1...amount {
            results.append(try convertByte(from: &iterator))
        }
        
        return results
    }

    private func convert8Bytes(from iterator: inout Data.Iterator) throws -> Double {
        
        let msb: UInt32 = try convert4Bytes(from: &iterator)
        let lsb: UInt32 = try convert4Bytes(from: &iterator)
        
        let value = msb ^ lsb
        
        return decodeSpecific(value)
    }
    
    private func convert4Bytes(from iterator: inout Data.Iterator) throws -> Double {
        
        let value: UInt32 = try convert4Bytes(from: &iterator)
        
        return decodeSpecific(value)
    }

    private func convert4Bytes(from iterator: inout Data.Iterator) throws -> UInt32 {
        
        var value = UInt32(try unwrap(iterator.next()))
        value |= UInt32(try unwrap(iterator.next())) << 8
        value |= UInt32(try unwrap(iterator.next())) << 16
        value |= UInt32(try unwrap(iterator.next())) << 24
        
        return value
    }

    private func convert2Bytes(from iterator: inout Data.Iterator) throws -> Double {
        
        var value = UInt16(try unwrap(iterator.next()))
        value |= UInt16(try unwrap(iterator.next())) << 8
        
        return decodeSpecific(value)
    }
    
    private func convertByte(from iterator: inout Data.Iterator) throws -> Double {
        
        let value = UInt8(try unwrap(iterator.next()))
        
        return decodeSpecific(value)
    }
    
    private func unwrap(_ byte: UInt8?) throws -> UInt8 {
        return try byte ?? {
            throw DecodeError.OutOfBounds
        }()
    }
    
    private func decodeSpecific(_ value: UInt32) -> Double {
        if T.self is Float.Type {
            return Double(Float32(bitPattern: value))
        }
        else if T.self is UInt.Type {
            return Double(UInt32(value))
        }
        else if T.self is Int.Type {
            return Double(Int32(value))
        }
        else {
            return Double(value)
        }
    }

    private func decodeSpecific(_ value: UInt16) -> Double {
        if T.self is Float.Type {
            return Double(Float32(bitPattern: UInt32(value)))
        }
        else if T.self is UInt.Type {
            return Double(UInt16(value))
        }
        else if T.self is Int.Type {
            return Double(toInt(value))
        }
        else {
            return Double(value)
        }
    }

    private func decodeSpecific(_ value: UInt8) -> Double {
        if T.self is Float.Type {
            return Double(Float32(bitPattern: UInt32(value)))
        }
        else if T.self is UInt.Type {
            return Double(value)
        }
        else if T.self is Int.Type {
            return Double(toInt(value))
        }
        else {
            return Double(value)
        }
    }
    
    private func toInt(_ unsigned: UInt16) -> Int16 {

        let signed = (unsigned <= UInt16(Int16.max)) ?
            Int16(unsigned) :
            Int16(unsigned - UInt16(Int16.max) - 1) + Int16.min

        return signed
    }

    private func toInt(_ unsigned: UInt8) -> Int8 {

        let signed = (unsigned <= UInt8(Int8.max)) ?
            Int8(unsigned) :
            Int8(unsigned - UInt8(Int8.max) - 1) + Int8.min

        return signed
    }
}
