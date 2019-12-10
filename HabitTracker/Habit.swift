//
//  Habit.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 10/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import Foundation


struct Habit: Identifiable, Codable{
    let id =  UUID()
    let type: String
    let name: String
    let schedule: String
    let numberOfTimesInWeek: String?
}


class HabitItems: ObservableObject{
    
    @Published var habits = [Habit](){
        didSet{
            
            let enc = JSONEncoder()
            if let encoded = try? enc.encode(habits){
                
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }
    
    init(){
        if let habits = UserDefaults.standard.data(forKey: "habits"){
            let decode = JSONDecoder()
            
            if let decoded = try? decode.decode([Habit].self, from: habits){
                self.habits = decoded
            }
        }
    }
    
}
