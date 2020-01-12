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
            
            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                Text("Habit Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()
                        
                
                ScrollView(.vertical){
                    ForEach(self.habitItems.habits, id: \.id){habit in
                        HabitRowView(habitItems: self.habitItems, habit: habit)
                    }
                }
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


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

