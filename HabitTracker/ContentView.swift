//
//  ContentView.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 10/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var addMoreScreenIsPresented = false
    
    
    @ObservedObject var habitItems = HabitItems()
    
    
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color.init(red: 48/255, green: 195/255, blue: 253/255), Color.init(red: 179/255, green: 74/255, blue: 254/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                    
                    Button(action: {
                        self.addMoreScreenIsPresented.toggle()
                    }){
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
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){ success, error in
                if success{
                    print("Permission Granted")
                }else if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

