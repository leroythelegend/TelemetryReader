//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

let DescriptionStringLength = 48

protocol Telemetry {

    var data: [String: [Double]] { get set }
    
    init(data iter: inout Data.Iterator) throws
}


