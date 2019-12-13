//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 11/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    
    let habit: Habit
    let habitItems: HabitItems
    
    @Environment(\.presentationMode) var presentationMode
    
    var formatterDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        print(habit.name, habit.id)
        
        return formatter.string(from: habit.startDate)
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ZStack{
                    
                    LinearGradient(gradient: Gradient(colors: [Color.init(red: 179/255, green: 74/255, blue: 254/255), Color.init(red: 48/255, green: 195/255, blue: 253/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading, spacing: 5){
            
                        HStack{
                            
                            VStack(alignment: .leading){
                                Text("Best Streak")
                                    .font(.title)
                                HStack(alignment: .center){
                                    Text("\(self.habit.bestStreak)")
                                        .font(.title)
                                    Image(systemName: "flame.fill")
                                        .resizable()
                                        .foregroundColor(Color.red)
                                        .frame(width: 20, height: 25)
                                }
                            }
                            
                            Spacer()
                            Divider()
                            
                            VStack(alignment: .leading){
                                Text("Current Streak")
                                    .font(.title)
                                HStack(alignment: .center){
                                    Text("\(self.habit.currentStreak)")
                                        .font(.title)
                                    Image(systemName: "flame")
                                        .resizable()
                                        .foregroundColor(Color.red)
                                        .frame(width: 20, height: 25)
                                }
                            }
                        }
                        .padding(40)
                        
                        Divider()
                        
                        VStack(alignment: .leading){
                            Text("Days done")
                                .font(.title)
                            HStack(alignment: .center){
                                Text("\(self.habit.numberOfCompletion)")
                                    .font(.title)
                                Image(systemName: "sparkles")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 20, height: 30)
                            }
                        }
                        .padding(40)
                        
                        Divider()
                        
                        Text("Following this habit from \(self.formatterDate) with \(self.habit.success*100, specifier: "%.2f")% success")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .italic()
                            .padding(40)
                        
                        HStack(){
                            Spacer()
                            Text(self.habit.type)
                                .font(.title)
                                .padding()
                                .foregroundColor(.red)
                                .background(Color.white)
                                .cornerRadius(50)
                            Spacer()
                        }
                        .padding(40)
                        
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(habit.name)
            .navigationBarItems(trailing:
                Button("Delete"){
                    self.habitItems.remove(withHabitId: self.habit.id)
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
