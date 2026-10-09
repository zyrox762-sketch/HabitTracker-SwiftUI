//
//  HabitTracker.swift
//  HabitTracker
//
//  Created by !---------? on 04/10/2026.
//

import Foundation
import SwiftUI

struct Habit:Identifiable{
    let id = UUID()
    let name:String
    let imageName:String
    let category:String
    let color:Color
    var isCompleted:Bool
}
