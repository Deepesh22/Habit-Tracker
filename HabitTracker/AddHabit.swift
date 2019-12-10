//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 10/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import SwiftUI

struct AddHabit: View {
    
    @ObservedObject var habitItems : HabitItems
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var schedule = ""
    @State private var type = "To Build"
    
    static let types = ["To Build", "To Quit"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Add Name", text: $name)
                
                Picker("Choose type of Habit", selection: $type){
                    ForEach(Self.types, id:\.self){
                        Text($0)
                    }
                }
                
                
                TextField("Schedule", text: $schedule)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                if self.name != "" {
                    let item = Habit(type: self.type, name: self.name, schedule: self.schedule, numberOfTimesInWeek: nil)
                        self.habitItems.habits.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}
