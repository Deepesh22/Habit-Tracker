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
    
    var formatterDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        
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
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                .frame(width: geo.size.width - 20, height: 80)
                                .padding()
                            VStack(alignment: .leading){
                                Text(self.habit.note)
                                    .font(.headline)
                            }
                            .padding(40)
                        }
                        
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
                        
                        HStack{
                            
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
                            
                            Spacer()
                            
                            VStack(alignment: .leading){
                                if self.habit.hasCompletedForToday{
                                    Text("Done Today")
                                        .font(.title)
                                        .foregroundColor(Color.green)
                                }else{
                                    Text("Not Done Today")
                                        .font(.title)
                                        .foregroundColor(Color.red)
                                }
                            }
                        }
                        .padding(40)
                        
                        
                        Text("Following this habit from \(self.formatterDate)")
                            .font(.headline)
                            .padding(40)
                        
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(habit.name)
        }
    }
}
