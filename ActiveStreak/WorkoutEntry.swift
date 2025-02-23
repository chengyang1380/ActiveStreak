//
//  WorkoutEntry.swift
//  ActiveStreak
//
//  Created by ChengYangChen on 2/18/25.
//

import Foundation

struct Exercise: Codable, Equatable {

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
        case glutes = "臀肌"
        case biceps = "二頭肌"
        case triceps = "三頭肌"
        case forearms = "前臂"
        case shouldersFront = "肩膀前束"
        case shouldersSide = "肩膀中束"
        case shouldersRear = "肩膀後束"
        case abs = "腹肌"
        case calves = "小腿"
    }

    let name: String
    let type: ExerciseType
    let muscleGroups: MuscleGroup

    // 胸部 - 槓鈴
    static let barbellBenchPress = Exercise(
        name: "自由重量槓鈴臥推", type: .freeWeight, muscleGroups: .chestMiddle)
    static let barbellInclineBenchPress = Exercise(
        name: "自由重量槓鈴上斜臥推", type: .freeWeight, muscleGroups: .chestUpper)
    static let smithMachineBenchPress = Exercise(
        name: "機械式史密斯臥推", type: .machine, muscleGroups: .chestMiddle)
    static let smithMachineInclineBenchPress = Exercise(
        name: "機械式史密斯上斜臥推", type: .machine, muscleGroups: .chestUpper)

    // 胸部 - 啞鈴
    static let dumbbellBenchPress = Exercise(
        name: "自由重量啞鈴臥推", type: .freeWeight, muscleGroups: .chestMiddle)
    static let dumbbellInclineBenchPress = Exercise(
        name: "自由重量啞鈴上斜臥推", type: .freeWeight, muscleGroups: .chestUpper)
    static let pecDeck = Exercise(
        name: "機械式夾胸", type: .machine, muscleGroups: .chestMiddle)

    // 腿部
    static let freeWeightSquat = Exercise(
        name: "自由重量深蹲", type: .freeWeight, muscleGroups: .quadsFront)
    static let freeWeightDeadlift = Exercise(
        name: "自由重量硬舉", type: .freeWeight, muscleGroups: .backLower)

    // 肩膀
    static let machineShoulderPress = Exercise(
        name: "機械式肩推", type: .machine, muscleGroups: .shouldersFront)
    static let freeWeightLateralRaise = Exercise(
        name: "自由重量啞鈴肩膀側飛鳥", type: .freeWeight, muscleGroups: .shouldersSide)
    static let freeWeightStandingShoulderPress = Exercise(
        name: "自由重量站姿肩推", type: .freeWeight, muscleGroups: .shouldersFront)
    static let machineSeatedShoulderPress = Exercise(
        name: "機械式坐姿肩推", type: .machine, muscleGroups: .shouldersFront)

    // 背部
    static let newWideGripPulldown = Exercise(
        name: "機械式滑輪下拉(新) 寬手把", type: .machine, muscleGroups: .backUpper)
    static let newNarrowGripPulldown = Exercise(
        name: "機械式滑輪下拉(新) 窄手把", type: .machine, muscleGroups: .backUpper)
    static let oldWideGripPulldown = Exercise(
        name: "機械式滑輪下拉(舊) 寬手把", type: .machine, muscleGroups: .backUpper)
    static let oldNarrowGripPulldown = Exercise(
        name: "機械式滑輪下拉(舊) 窄手把", type: .machine, muscleGroups: .backUpper)
    static let newNarrowGripRow = Exercise(
        name: "機械式平行划船(新) 窄手把", type: .machine, muscleGroups: .backMiddle)
    static let oldFixedHandleRow = Exercise(
        name: "機械式平行划船(舊) 不可調手把", type: .machine, muscleGroups: .backMiddle)

    // 二頭肌
    static let freeWeightBicepCurl = Exercise(
        name: "自由重量二頭彎舉", type: .freeWeight, muscleGroups: .biceps)
    static let machineBicepCurl = Exercise(
        name: "機械式二頭彎舉", type: .machine, muscleGroups: .biceps)

    // 三頭肌
    static let freeWeightTricepExtension = Exercise(
        name: "自由重量三頭彎舉", type: .freeWeight, muscleGroups: .triceps)
    static let machineTricepPushdown = Exercise(
        name: "機械式三頭繩索下拉", type: .machine, muscleGroups: .triceps)
    static let machineTricepExtension = Exercise(
        name: "機械式三頭彎舉", type: .machine, muscleGroups: .triceps)

    // 腹肌
    static let machineCrunch = Exercise(
        name: "機械式腹肌前彎", type: .machine, muscleGroups: .abs)
    static let machineObliqueTwist = Exercise(
        name: "機械式腹肌側轉", type: .machine, muscleGroups: .abs)

    static func custom(name: String, type: ExerciseType, muscleGroup: MuscleGroup) -> Exercise {
        return Exercise(name: name, type: type, muscleGroups: muscleGroup)
    }
}

struct WorkoutEntry: Identifiable, Codable, Equatable {
    let id: UUID
    let exercise: Exercise
    let weight: Double
    let sets: Int
    let reps: Int
    let perceivedEffort: Int
    let date: Date
}


extension WorkoutEntry {
    static let mock = Self(id: UUID(), exercise: .freeWeightSquat, weight: 120, sets: 5, reps: 5, perceivedEffort: 3, date: Date())
}
