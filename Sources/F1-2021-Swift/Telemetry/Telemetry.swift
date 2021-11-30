//
//  File.swift
//  
//
//  Created by Leigh McLean on 23/11/21.
//

import Foundation

class Telemetry {
    
    let DescriptionStringLength = 48
    var data: [String: [Double]] = [:]
    
    required init(data iter: inout Data.Iterator) throws {}
}


