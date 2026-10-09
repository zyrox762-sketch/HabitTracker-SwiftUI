//
//  HomeView.swift
//  HabitTracker
//
//  Created by !---------? on 04/10/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HabitViewModel()
    @State var showSheet:Bool = false
    @State private var offsetX: CGFloat = 0
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 8){
                    Text("Overall Progress")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    ProgressView(value: vm.progress)
                        .tint(.green)
                        .progressViewStyle(.linear)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                    Text("\(vm.completeHabits) of \(vm.habits.count) habits completed")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    Text("\(vm.remainingHabits) habits remaining")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    ForEach(vm.habits) { habit in
                        HabitRowView(
                                habit: habit,
                                onToggle: {
                                    vm.toggleHabit(habit: habit)
                                },
                                onDelete: {
                                    vm.deleteHabit(habit: habit)
                                }
                            )
                        .padding(12)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(14)
                        .padding(.vertical)
                    }
                    Spacer()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showSheet = true
            }, label: {
                Image(systemName: "plus.app")
                    .font(.title2)
                    .accentColor(.red)
            }))
            .sheet(isPresented: $showSheet, content: {
                AddHabitView()
                    .environmentObject(vm)
            })
            .padding()
            .navigationTitle("My Habits")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
