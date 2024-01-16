//
//  Extensions.swift
//  meditation
//
//  Created by Иван Чернокнижников on 16.01.2024.
//

import Foundation


extension DateComponentsFormatter {
    static let abbreviated: DateComponentsFormatter = {
        print("Init DateComponentsFormatter.abbreviated")
        let formatted = DateComponentsFormatter()
        
        formatted.allowedUnits = [.hour,.minute,.second]
        formatted.unitsStyle = .abbreviated
        return formatted
    }()
    
    static let positional: DateComponentsFormatter = {
        print("Init DateComponentsFormatter.positional")
        let formatted = DateComponentsFormatter()
        
        formatted.allowedUnits = [.minute,.second]
        formatted.unitsStyle = .positional
        formatted.zeroFormattingBehavior = .pad
        return formatted
    }()
}
