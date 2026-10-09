//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by !---------? on 08/10/2026.
//

import SwiftUI
import Foundation

struct AddHabitView: View {
    
    @State var habitName:String = ""
    @State var selectedCategory:String = "Health"
    @State private var selectedIcon: String = "drop.fill"
    @State var showAlert:Bool = false
    @EnvironmentObject var vm:HabitViewModel
    @Environment(\.dismiss) var dismiss
    
    let categories = [
        "Health",
        "Fitness",
        "Learning",
        "Personal Growth",
        "Other"
    ]
    let habitIcons = [
        "drop.fill",
        "figure.walk",
        "book.fill",
        "brain",
        "heart.fill",
        "bed.double.fill",
        "leaf.fill",
        "dumbbell.fill"
    ]
    
    var body: some View {
        NavigationView{
            VStack(spacing: 8){
                Text("Habit Name")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(18)
                
                TextField("Enter habit name...", text: $habitName)
                    .padding(14)
                    .font(.body)
                    .background(.secondary)
                    .opacity(0.5)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                HStack{
                    Text("Category")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(14)
                    Spacer()
                    Picker("Select", selection: $selectedCategory) {
                        ForEach(categories,id:\.self) { habit in
                            Text("\(habit)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical,12)
                .background(.secondary)
                .opacity(0.5)
                .cornerRadius(10)
                .padding(14)
                HStack{
                    Text("Icons")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(14)
                    Spacer()
                    Picker("Select", selection: $selectedIcon) {
                        ForEach(habitIcons,id:\.self) { habit in
                            Image(systemName: habit)
                                .font(.system(size: 24))
                                
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical,12)
                .background(.secondary)
                .opacity(0.5)
                .cornerRadius(10)
                .padding(14)
                Spacer()
                
            }
            .navigationTitle("New Habit")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {
                            if habitName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                showAlert = true
                            } else {
                                let trimmedName = habitName.trimmingCharacters(in: .whitespacesAndNewlines)
                                vm.addHabit(
                                    name: trimmedName,
                                    imageName: selectedIcon,
                                    category: selectedCategory
                                )
                                dismiss()
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Habit Name Required"),
                        message: Text("Please enter a name for your habit before saving."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
}
}
struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView()
            .environmentObject(HabitViewModel())
    }
}
