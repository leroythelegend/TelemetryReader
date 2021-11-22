//
//  File.swift
//  
//
//  Created by Leigh McLean on 21/11/21.
//

import Foundation

protocol Decode {
    associatedtype T
    func data(amount : Int, from iterator: inout Data.Iterator) throws -> [T]
}
