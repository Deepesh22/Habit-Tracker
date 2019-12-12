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
    @State private var dateTarget = Date()
    @State private var type = "To Build"
    @State private var note = ""
    
    var daysSinceNow: Int{
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM-dd-yyyy"
        
        let today = formatter.date(from: formatter.string(from: Date()))!

        let formatted = formatter.date(from: formatter.string(from: dateTarget))!
        
        return Calendar.current.dateComponents([.day], from: today, to: formatted).day!
    }
    
    
    static let types = ["To Build", "To Quit"]
    
    var body: some View {
        NavigationView{
                Form{
                    Section{
                        TextField("Add Name", text: $name)
                        
                        TextField("Add a note", text: $note)
                    }

                    Section(header: Text("Habit is..")){
                        Picker("Choose type of Habit", selection: $type){
                            ForEach(Self.types, id:\.self){
                                Text($0)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                    
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                if self.name != "" && self.note != ""{
                    let item = Habit(type: self.type, name: self.name, note: self.note)
                        self.habitItems.habits.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}
