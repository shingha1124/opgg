//
//  Model+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import Foundation

extension Game {
    var createDateToValue: (value: String, suffix: String) {
        let createDate = Date(timeIntervalSince1970: TimeInterval(createDate))
        let diff = Calendar.current.dateComponents([.minute, .hour, .day], from: createDate, to: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        
        var suffix = dateFormatter.string(from: createDate)
        var value = ""
        if let day = diff.day, day > 1 {
            value = day <= 7 ? "\(day)" : ""
            suffix = day <= 7 ? "Day Ago".localized() : suffix
        } else if let hour = diff.hour, hour > 1 {
            value = "\(hour)"
            suffix = "Hour Ago".localized()
        } else if let minute = diff.minute {
            value = "\(minute)"
            suffix = "Minute Ago".localized()
        } else {
            suffix = "방금 전"
        }
        
        return (value, suffix)
    }
}
