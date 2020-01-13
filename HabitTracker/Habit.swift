//
//  Habit.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 10/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import Foundation
import UserNotifications

struct Habit: Identifiable, Codable{
    
    let id : UUID = UUID()
    let type: String
    let name: String
    let note: String
    let startDate: Date
    var bestStreak: Int = 0
    var currentStreak: Int = 0
    var lastCompletionDate: Date?
    var numberOfCompletion: Int = 0
    
    var reminder: Bool?

    var reminderTitle: String?
    var reminderTime: Date?
    
    
    var calculatedCurrentStreak: Int{
        if let lastDate = lastCompletionDate{
            if lastDate.isYesterday || lastDate.isToday{
                return currentStreak
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    var totalDays: Int{
        return countDays(startDate, Date()) + 1
    }
    
    var success: Double{
        return  Double(numberOfCompletion) / Double(totalDays)
    }
    
    var hasCompletedForToday: Bool{
        return lastCompletionDate?.isToday ?? false
    }
    
}


class HabitItems: ObservableObject{
    
    @Published var habits = [Habit](){
        didSet{
            
            let enc = JSONEncoder()
            if let encoded = try? enc.encode(habits){
                
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
            else{
                print("ERROR in encoding")
            }
        }
    }
    
    init(){
        if let habits = UserDefaults.standard.data(forKey: "habits"){
            let decode = JSONDecoder()
            
            if let decoded = try? decode.decode([Habit].self, from: habits){
                self.habits = decoded
            }else{
                print("Eror decoding")
            }
        }else{
            print("Error finding key")
        }
    }
    
    
    func complete(withHabitId: UUID){
        for index in 0..<self.habits.count{
            if self.habits[index].id == withHabitId{
                self.habits[index].currentStreak = self.habits[index].calculatedCurrentStreak + 1
                self.habits[index].lastCompletionDate = Date()
                if self.habits[index].currentStreak >= self.habits[index].bestStreak{
                    self.habits[index].bestStreak =  self.habits[index].currentStreak
                }
                self.habits[index].numberOfCompletion += 1
                
                break
            }
        }
    }
    
    func setReminder(withHabitId: UUID, setValue: Bool, title: String, date: Date){
        for index in 0..<self.habits.count{
            if self.habits[index].id == withHabitId{
                self.habits[index].reminder = setValue
                self.habits[index].reminderTitle = title
                self.habits[index].reminderTime = date
                
                if setValue == true{
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.sound = UNNotificationSound.default

                    var dateComponents = DateComponents()
                    dateComponents.hour = Calendar.current.component(.hour, from: date)
                    dateComponents.minute = Calendar.current.component(.minute, from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                    
                    print("Notification Added")
                
                }else{
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    print("Notification Removed")
                }
                
                break
            }
        }
    }
    
    
    func remove(withHabitId: UUID){
        var habitTobeRemoved = 0
        for index in 0..<self.habits.count{
            if self.habits[index].id == withHabitId{
                habitTobeRemoved = index
                break
            }
        }
        
        self.habits.remove(at: habitTobeRemoved)
    }
    
}



func countDays(_ from: Date, _ to: Date) -> Int{
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM-dd-yyyy"
    
    let formattedFrom = formatter.date(from: formatter.string(from: from))!

    let formattedTo = formatter.date(from: formatter.string(from: to))!
    
    return Calendar.current.dateComponents([.day], from: formattedFrom, to: formattedTo).day!
}
