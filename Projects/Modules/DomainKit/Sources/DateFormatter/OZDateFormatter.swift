//
//  OZDateFormatter.swift
//  DomainKit
//
//  Created by 신의연 on 11/26/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public class OZDateFormatter {
        
    public static func convertStringToDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMDD"
        
        return dateFormatter.date(from: date)
    }
    
    public static func convertDateToString(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY. MM. DD"
        
        return dateFormatter.string(from: date)
    }
    
    public static func convertStringToDateString(date: String) -> String? {
        guard let convertedDate = convertStringToDate(date: date) else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY. MM. DD"
        return dateFormatter.string(from: convertedDate)
    }
}
