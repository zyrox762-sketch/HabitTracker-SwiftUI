//
//  HabitTrackerViewModel.swift
//  HabitTracker
//
//  Created by !---------? on 04/10/2026.
//

import Foundation

class HabitViewModel:ObservableObject{
    @Published var habits:[Habit] = [
        Habit(name: "Drink Water", imageName: "drop.fill", category: "Health", color: .blue, isCompleted: true),
        Habit(name: "Exercise", imageName: "figure.walk.circle.fill", category: "Fitness", color: .orange, isCompleted: true),
        Habit(name: "Read", imageName: "book.circle.fill", category: "Personal Growth", color: .purple, isCompleted: false),
        Habit(name: "Swift Practice", imageName: "brain", category: "Learning", color: .green, isCompleted: false),
        Habit(name: "Walk", imageName: "figure.walk", category: "Health", color: .yellow, isCompleted: true)
    ]
    @Published var checkCompleted:String = ""
    
    func toggleHabit(habit: Habit) {
        if let index = habits.firstIndex(where: { currentHabit in
            currentHabit.id == habit.id
        }) {
            habits[index].isCompleted = !habits[index].isCompleted
        }
    }
    
    func addHabit(name:String,imageName:String,category:String){
        let isCompleted:Bool = false
        habits.append(Habit(name: name, imageName: imageName, category: category, color: .red, isCompleted: isCompleted))
    }
    
    func deleteHabit(habit: Habit) {
        print("Delete tapped: \(habit.name)")

        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits.remove(at: index)
        } else {
        }
    }
    
    var completeHabits:Int{
        habits.filter {
            $0.isCompleted
        }.count
    }
    
    var remainingHabits:Int{
        return habits.count - completeHabits
    }
    
    var progress:Double{
        if habits.count == 0{
            return 0
        }
        return Double(completeHabits) / Double(habits.count)
    }
}
