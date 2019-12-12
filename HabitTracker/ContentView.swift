//
//  ContentView.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 10/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var addMoreScreenIsPresented = false
    @State private var detailScreenIsPresented = false
    
    @ObservedObject var habitItems = HabitItems()
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color.init(red: 48/255, green: 195/255, blue: 253/255), Color.init(red: 179/255, green: 74/255, blue: 254/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                
                GeometryReader{ geo in
                    List{
                        ForEach(self.habitItems.habits, id: \.id){habit in
                            
                            NavigationLink(destination: HabitDetailView(habit: habit, habitItems: self.habitItems)){
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                        .frame(width: geo.size.width - 20, height: 80)
                                    VStack {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(habit.name)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                Text(habit.note)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding(20)
                                            
                                            Spacer()
                                            
                                            VStack(alignment: .trailing){
                                                Button(action: {
                                                    self.habitItems.complete(withHabitId: habit.id)
                                                }) {
                                                    ZStack {
                                                        Circle()
                                                            .foregroundColor(habit.hasCompletedForToday ? Color.green : Color.red)
                                                            .frame(width: 44, height: 44)
                                                        Image(systemName: "checkmark")
                                                            .font(.headline)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                                .padding(20)
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .onDelete(perform: self.remove)
                    }
                        
                    .padding(.top, 16)
                    
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            
                            Button(action: {self.addMoreScreenIsPresented.toggle()}){
                                Text("+")
                                    .font(.largeTitle)
                            }
                            .foregroundColor(Color.white)
                            .frame(width: 80, height: 80)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .padding()
                            .shadow(color: Color.black, radius: 10, x: 5, y: 5)
                        }
                    }
                }
                    
                .navigationBarTitle("Habit Tracker")
                .navigationBarItems(trailing: EditButton()) 
                .sheet(isPresented: $addMoreScreenIsPresented){
                    AddHabit(habitItems: self.habitItems)
                }
            }
        }
    }
        
        
    func remove(at offset: IndexSet){
        habitItems.habits.remove(atOffsets: offset)
    }
    
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}
