//
//  Helper.swift
//  Messenger
//
//  Created by Genusys Inc on 8/11/22.
//

import Foundation

class Helper{
    
     static let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
         formatter.dateStyle = .medium
         formatter.timeStyle = .long
         formatter.locale = .current
        return formatter
    }()
}
