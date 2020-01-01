//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by Deepesh Deshmukh on 13/12/19.
//  Copyright © 2019 Deepesh Deshmukh. All rights reserved.
//

import SwiftUI

struct HabitRowView: View {
    
    let habitItems: HabitItems
    let habit: Habit
    
    @State private var detailScreenIsPresented = false
    
    var body: some View {
        
        //GeometryReader{ geo in
        
            Button(action: {
                self.detailScreenIsPresented.toggle()
            }){
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
//                        .frame(width: 300, height: 80)
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(self.habit.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(self.habit.note)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(20)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing){
                                Button(action: {
                                    withAnimation{
                                        self.habitItems.complete(withHabitId: self.habit.id)
                                    }
                                }) {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(self.habit.hasCompletedForToday ? Color.green : Color.red)
                                            .frame(width: 44, height: 44)
                                        Image(systemName: "checkmark")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                }
                                .disabled(self.habit.hasCompletedForToday)
                                .padding(20)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
            .sheet(isPresented: self.$detailScreenIsPresented){
                HabitDetailView(habit: self.habit, habitItems: self.habitItems)
            }
//        }
    }
}
