//
//  File.swift
//  
//
//  Created by Leigh McLean on 28/11/21.
//

import Foundation

extension Array where Element == Double {
    
    func toString() -> String {
        var result: String = String()
        for d in self {
            result.append(Character(Unicode.Scalar(Int(d))!))
        }
        return result
    }
    
    func and(at i: Int, with: UInt) -> UInt {
        return UInt(self[i]) & with
    }
}
