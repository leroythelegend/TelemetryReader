//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

///
/// Different types of telemetry
///

public protocol Telemetry {

    ///
    /// String is the name of the type of telemetry
    /// and Double Array is the associated data.
    ///

    var data: [String: [Double]] { get set }
    
    ///
    /// - parameter data: Is an iterator of the data captured from the games output.
    ///

    init(data iter: inout Data.Iterator) throws
}


