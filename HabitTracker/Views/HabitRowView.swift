//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by !---------? on 08/10/2026.
//

import SwiftUI

struct HabitRowView: View {
    
    let habit: Habit
    let onToggle: () -> Void
    let onDelete: () -> Void

    @State private var offsetX: CGFloat = 0
    @EnvironmentObject var vm:HabitViewModel
    
    var body: some View {
        HStack{
            Image(systemName: habit.imageName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .foregroundColor(habit.color)
                .padding(.horizontal)
            VStack(alignment: .leading, spacing: 8){
                Text(habit.name)
                    .font(.headline)
                Text(habit.category)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button {
                onToggle()
            } label: {
                Image(systemName: habit.isCompleted ? "checkmark.circle.fill": "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(habit.isCompleted ? .green:.gray.opacity(0.4))
            }
        }
        
        .offset(x: offsetX)
        .gesture(
                    DragGesture()
                        .onChanged { value in
                            offsetX = value.translation.width
                        }
                        .onEnded { value in
                            if value.translation.width < -100{
                                onDelete()
                            }
                            else{
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    offsetX = 0
                                }
                            }
                        }
                )
    }
}

struct HabitRowView_Previews: PreviewProvider {
    static var previews: some View {
        HabitRowView(
            habit: Habit(
                name: "Drink Water",
                imageName: "drop.fill",
                category: "Health", color: .red,
                isCompleted: true
            ),
            onToggle: {},
            onDelete: {}
        )
    }
}
