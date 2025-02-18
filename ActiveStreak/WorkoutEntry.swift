//
//  WorkoutEntry.swift
//  ActiveStreak
//
//  Created by ChengYangChen on 2/18/25.
//

import Foundation

enum ExerciseType: String, Codable, CaseIterable {
    case freeWeight
    case machine
}

enum MuscleGroup: String, Codable, CaseIterable {
    case chestUpper = "上胸"
    case chestMiddle = "平胸"
    case chestLower = "下胸"
    case backUpper = "上背"
    case backMiddle = "中背"
    case backLower = "下背"
    case quadsFront = "股四頭肌（前側）"
    case quadsRear = "股四頭肌（後側）"
    case hamstrings = "腿後腱"
    case glutes = "臀部"
    case biceps = "二頭肌"
    case triceps = "三頭肌"
    case forearms = "前臂"
    case shouldersFront = "肩膀前束"
    case shouldersSide = "肩膀中束"
    case shouldersRear = "肩膀後束"
    case abs = "腹肌"
    case obliques = "斜腹肌"
    case calves = "小腿"
}

struct Exercise: Codable, Equatable {
    let name: String
    let type: ExerciseType

    static let benchPress = Exercise(name: "臥推", type: .freeWeight)
    static let squat = Exercise(name: "深蹲", type: .freeWeight)
    static let deadlift = Exercise(name: "硬舉", type: .freeWeight)
    static let legPress = Exercise(name: "腿推機", type: .machine)

    static func custom(name: String, type: ExerciseType) -> Exercise {
        return Exercise(name: name, type: type)
    }
}

struct WorkoutEntry: Identifiable, Codable, Equatable {
    let id: UUID
    let exercise: Exercise
    let primaryMuscle: MuscleGroup
    let secondaryMuscle: MuscleGroup?
    let weight: Double
    let sets: Int
    let reps: Int
    let perceivedEffort: Int
    let date: Date
}
