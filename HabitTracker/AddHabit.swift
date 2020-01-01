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
            GeometryReader{ geo in
                ZStack{
                    
                    LinearGradient(gradient: Gradient(colors: [Color.init(red: 179/255, green: 74/255, blue: 254/255), Color.init(red: 48/255, green: 195/255, blue: 253/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading, spacing: 5){
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                .frame(width: geo.size.width - 20, height: 80)
                            VStack(alignment: .leading){
                                Text("So what's the habit???")
                                TextField("Add Name", text: self.$name)
                            }
                            .padding(40)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                .frame(width: geo.size.width - 20, height: 80)
                            VStack(alignment: .leading){
                                Text("This habit is all about???")
                                TextField("Add a note", text: self.$note)
                            }
                            .padding(40)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                .frame(width: geo.size.width - 20, height: 80)
                            VStack(alignment: .leading){
                                Text("The habit is to...")
                                Picker("Choose type of Habit", selection: self.$type){
                                    ForEach(Self.types, id:\.self){
                                        Text($0)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            .padding(40)
                        }
                        Spacer()
                    }
                }
            }
                
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                if self.name != "" && self.note != ""{
                    let item = Habit(type: self.type, name: self.name, note: self.note, startDate: Date())
                    self.habitItems.habits.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(PlainButtonStyle())
            )
        }
    }
}
