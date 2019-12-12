//
//  DateExtention.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 12/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import Foundation


extension Date {
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }

    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }

    var isYesterday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
    
    func countDays(_ from: Date, _ to: Date) -> Int{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM-dd-yyyy"
        
        let formattedFrom = formatter.date(from: formatter.string(from: from))!

        let formattedTo = formatter.date(from: formatter.string(from: to))!
        
        return Calendar.current.dateComponents([.day], from: formattedFrom, to: formattedTo).day!
    }
}
