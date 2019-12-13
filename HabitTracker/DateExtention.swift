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
}
