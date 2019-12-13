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
    
    
    @ObservedObject var habitItems = HabitItems()
    
    
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color.init(red: 48/255, green: 195/255, blue: 253/255), Color.init(red: 179/255, green: 74/255, blue: 254/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            
            GeometryReader{ geo in
                
                ScrollView(.vertical){
                    VStack(){
                        Text("Habit Tracker")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                        
                        ForEach(self.habitItems.habits, id: \.id){habit in
                            HabitRowView(habitItems: self.habitItems, habit: habit)
                        }
                    }
                }
                .padding(.top, 16)
            }
            
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
        .sheet(isPresented: $addMoreScreenIsPresented){
            AddHabit(habitItems: self.habitItems)
        }
    }
}
