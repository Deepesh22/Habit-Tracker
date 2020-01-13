//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 11/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    
    var habit: Habit
    let habitItems: HabitItems
        
    @Environment(\.presentationMode) var presentationMode
    
    var formatterDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        print(habit.name, habit.id)
        
        return formatter.string(from: habit.startDate)
    }
    
    var time: String{
        var hour = Calendar.current.component(.hour, from: self.habit.reminderTime)
        let minute = Calendar.current.component(.minute, from: self.habit.reminderTime)
        var holder = "AM"
        if hour > 12{
            hour -= 12
            holder = "PM"
        }
        return "\(hour):\(minute) \(holder)"
    }

    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text(habit.name)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.primary)
                    ){
                    Text(self.habit.type)
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                    
                    Text(self.habit.note)
                        .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                        
                Section(header: Text("Your Streaks")
                                    .foregroundColor(.primary)
                                    .fontWeight(.heavy)
                                    .font(.headline)
                    ){
                    HStack{
                    
                        VStack(){
                            Text("Best")
                                .font(.title)
                            HStack(){
                                 Text("\(self.habit.bestStreak)")
                                    .font(.title)
                                Image(systemName: "star.fill")
                                     .resizable()
                                     .foregroundColor(Color.init(red: 1, green: 215/255, blue: 0))
                                     .frame(width: 50, height: 50)
                            }
                        }
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        Spacer()
                        
                        VStack(){
                            Text("Current")
                                .font(.title)
                            HStack(){
                                Text("\(self.habit.calculatedCurrentStreak)")
                                    .font(.title)
                                Image(systemName: "star")
                                    .resizable()
                                    .foregroundColor(Color.init(red: 1, green: 215/255, blue: 0))
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }
                    .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                        
                }
                
                Section(header: Text("About Your Consistency")
                                    .foregroundColor(.primary)
                                    .fontWeight(.heavy)
                                    .font(.headline)
                    ){
                    HStack{
                        VStack(){
                            Text("Days done")
                                .font(.title)
                            HStack(alignment: .center){
                                Text("\(self.habit.numberOfCompletion)")
                                    .font(.title)
                                Image(systemName: "stopwatch")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        Spacer()
                        
                        VStack(){
                            Text("Total Days")
                                .font(.title)
                            HStack(alignment: .center){
                                Text("\(self.habit.totalDays)")
                                    .font(.title)
                                Image(systemName: "stopwatch.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))

                    }
                        
                    Text("Following this habit from \(self.formatterDate) with \(self.habit.success*100, specifier: "%.2f")% success")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .italic()
                    .padding(.init(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
                
                Section(header: Text("Reminders")
                                    .foregroundColor(.primary)
                                    .fontWeight(.heavy)
                                    .font(.headline)
                    ){
                        Button(action: {
                            if self.habit.reminder!{
                                self.habitItems.setReminder(withHabitId: self.habit.id, setValue: false)
                            }else{
                                self.habitItems.setReminder(withHabitId: self.habit.id, setValue: true)
                            }
                        }){
                            if self.habit.reminder!{
                                Text("On")
                            }else{
                                Text("Off")
                            }
                        }
                        if self.habit.reminder!{
                            VStack{
                                HStack{
                                    Image(systemName: "bell.fill")
                                        .renderingMode(.original)
                                    Text("Daily at \(self.time)")
                                        .fontWeight(.heavy)
                                        
                                }
                                Text("Message -> \(self.habit.reminderTitle)")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.secondary)
                        }
                }
            }
            .navigationBarItems(trailing:
                Button("Delete"){
                    self.habitItems.remove(withHabitId: self.habit.id)
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct HabitDetailView_Previews : PreviewProvider {
    static var previews: some View {
        HabitDetailView(habit: Habit(type: "type", name: "name", note: "note", startDate: Date(), reminderTitle: "Random", reminderTime: Date()), habitItems: HabitItems())
    }
}
