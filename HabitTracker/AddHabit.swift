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
    
    @State private var showingReminder = true
    @State private var showingPicker = false
    @State private var contentTitle = ""
    @State private var time = defaultReminderTime

    static var defaultReminderTime: Date{
        return Date()
    }
    
    static let types = ["To Build", "To Quit"]
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ZStack{
                    
                    LinearGradient(gradient: Gradient(colors: [Color.init(red: 48/255, green: 195/255, blue: 253/255), Color.init(red: 179/255, green: 74/255, blue: 254/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        VStack(alignment: .leading, spacing: 20){

                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("So what's the habit???")
                                    TextField("Add Name for the habit...", text: self.$name)
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }
                            .padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("This habit is all about???")
                                    TextField("Add a note describing it...", text: self.$note)
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
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
                                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 40))
                            }
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading){
                            Toggle(isOn: self.$showingReminder.animation()){
                                Text("Reminder")
                            }
                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            
                            if self.showingReminder{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                        .frame(width: geo.size.width - 20, height: 80)
                                    VStack(alignment: .leading){
                                        HStack{
                                            Image(systemName: "text.bubble")
                                            Text("Reminder Message")
                                        }
                                        TextField("Add a message for reminder...", text: self.$contentTitle)
                                    }
                                    .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                                }
                                
                                VStack (alignment: .leading){
                                    HStack{
                                        Image(systemName: "clock")
                                        Text("Reminder Time")
                                    }
                                    
                                    DatePicker("Select time", selection: self.$time, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .datePickerStyle(WheelDatePickerStyle())
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }
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
                    self.habitItems.setReminder(withHabitId: item.id, setValue: self.showingReminder, title: self.contentTitle, date: self.time)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(PlainButtonStyle())
            )
        }
    }
}

struct AddHabit_Previews : PreviewProvider {
    static var previews: some View {
        AddHabit(habitItems: HabitItems())
    }
}
