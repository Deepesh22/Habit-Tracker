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
    
    var body: some View {
        Form{
            Text(habit.type)
            Text(habit.name)
            Text(habit.note)
            if habit.hasCompletedForToday{
                Text("Done For Today")
            }else{
                Text("Not Done Today")
            }
        }
    }
}
