//
//  Habit.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 10/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import Foundation


struct Habit: Identifiable, Codable{
    
    let id : UUID = UUID()
    let type: String
    let name: String
    let note: String
    let startDate: Date = Date()
    var bestStreak: Int = 0
    var currentStreak: Int = 0
    var lastCompletionDate: Date?
    var numberOfCompletion: Int = 0
    
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
                self.habits[index].lastCompletionDate = Date()
                self.habits[index].currentStreak += 1
                if self.habits[index].currentStreak >= self.habits[index].bestStreak{
                    self.habits[index].bestStreak =  self.habits[index].currentStreak
                }
                self.habits[index].numberOfCompletion += 1
                
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
