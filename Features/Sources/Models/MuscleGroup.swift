//
//  MuscleGroup.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import Foundation

public struct Exercise: Codable, Equatable {

//    public enum ExerciseType: String, Codable, CaseIterable {
//        case freeWeight
//        case machine
//    }

    public struct Weight: Codable, Equatable {
        public enum WeightUnit: String, Codable, CaseIterable {
            case kg = "公斤"
            case lb = "磅"
        }

        public var value: Double
        public var unit: WeightUnit

        public func converted(to targetUnit: WeightUnit) -> Double {
            switch (unit, targetUnit) {
            case (.kg, .lb):
                return value * 2.20462
            case (.lb, .kg):
                return value / 2.20462
            default:
                return value
            }
        }
    }

    public let name: String
//    public let exerciseType: ExerciseType
    public let muscleGroups: MuscleGroup
    public let weight: Weight
}


public enum MuscleGroup: Codable, Equatable {
    case chest(ChestExercise)
    case back(BackExercise)
    case legs(LegExercise)
    case biceps(BicepsExercise)
    case triceps(TricepsExercise)
    case shoulders(ShouldersExercise)
    case abs(AbsExercise)
}


public enum ChestExercise: Codable, Equatable {
    case barbellBenchPress
    case dumbbellBenchPress
    case dumbbellInclineBenchPress
    case machineBenchPress
    case machinePecDeck
    case cablePecDeck
    case custom(String)

    static var builtInCases: [ChestExercise] {
        return [
            .barbellBenchPress,
            .dumbbellBenchPress,
            .dumbbellInclineBenchPress,
            .machineBenchPress,
            .machinePecDeck,
            .cablePecDeck
        ]
    }

    public var name: String {
        switch self {
            case .barbellBenchPress: return "槓鈴臥推"
            case .dumbbellBenchPress: return "啞鈴臥推"
            case .dumbbellInclineBenchPress: return "啞鈴上斜臥推"
            case .machineBenchPress: return "機械臥推"
            case .machinePecDeck: return "機械夾胸"
            case .cablePecDeck: return "Cable 夾胸"
            case .custom(let name): return name
        }
    }
}


public enum BackExercise: Codable, Equatable {
    case pullUp
    case barbellRow
    case dumbbellRow
    case latPulldownNew
    case latPulldownOld
    case seatedRowNew
    case seatedRowOld
    case custom(String)

    static var builtInCases: [BackExercise] {
        return [
            .pullUp,
            .barbellRow,
            .dumbbellRow,
            .latPulldownNew,
            .latPulldownOld,
            .seatedRowNew,
            .seatedRowOld
        ]
    }

    public var name: String {
        switch self {
            case .pullUp: return "引體向上"
            case .barbellRow: return "槓鈴划船"
            case .dumbbellRow: return "啞鈴划船"
            case .latPulldownNew: return "滑輪下拉（新）"
            case .latPulldownOld: return "滑輪下拉（舊）"
            case .seatedRowNew: return "坐姿划船（新）"
            case .seatedRowOld: return "坐姿划船（舊）"
            case .custom(let name): return name
        }
    }
}


public enum LegExercise: Codable, Equatable {
    case barbellSquat
    case barbellDeadlift
    case barbellSplitSquat
    case dumbbellSplitSquat
    case trapBarDeadlift
    case legPressNew
    case legPressOld
    case hipThrustMachine
    case legExtensionMachine
    case custom(String)

    var name: String {
        switch self {
            case .barbellSquat: return "槓鈴深蹲"
            case .barbellDeadlift: return "槓鈴硬舉"
            case .barbellSplitSquat: return "槓鈴分腿蹲"
            case .dumbbellSplitSquat: return "啞鈴分腿蹲"
            case .trapBarDeadlift: return "六角槓硬舉"
            case .legPressNew: return "腿推機（新）"
            case .legPressOld: return "腿推機（舊）"
            case .hipThrustMachine: return "臀部後推機"
            case .legExtensionMachine: return "腿伸機"
            case .custom(let name): return name
        }
    }
}

public enum BicepsExercise: Codable, Equatable {
    case dumbbellCurl
    case barbellCurl
    case machineCurl
    case custom(String)

    static var builtInCases: [BicepsExercise] {
        return [
            .dumbbellCurl,
            .barbellCurl,
            .machineCurl
        ]
    }

    public var name: String {
        switch self {
            case .dumbbellCurl: return "啞鈴彎舉"
            case .barbellCurl: return "槓鈴彎舉"
            case .machineCurl: return "機械彎舉"
            case .custom(let name): return name
        }
    }
}


public enum TricepsExercise: Codable, Equatable {
    case machineExtension
    case dumbbellOverheadExtension
    case cablePushdown
    case custom(String)

    static var builtInCases: [TricepsExercise] {
        return [
            .machineExtension,
            .dumbbellOverheadExtension,
            .cablePushdown
        ]
    }

    public var name: String {
        switch self {
            case .machineExtension: return "機械三頭屈伸"
            case .dumbbellOverheadExtension: return "啞鈴頸後臂屈伸"
            case .cablePushdown: return "Cable機三頭肌下推"
            case .custom(let name): return name
        }
    }
}

public enum ShouldersExercise: Codable, Equatable {
    case lateralRaise
    case standingBarbellPress
    case standingDumbbellPress
    case seatedBarbellPress
    case seatedDumbbellPress
    case machinePress
    case custom(String)

    static var builtInCases: [ShouldersExercise] {
        return [
            .lateralRaise,
            .standingBarbellPress,
            .standingDumbbellPress,
            .seatedBarbellPress,
            .seatedDumbbellPress,
            .machinePress
        ]
    }

    public var name: String {
        switch self {
            case .lateralRaise: return "肩膀側平舉"
            case .standingBarbellPress: return "站姿槓鈴肩推"
            case .standingDumbbellPress: return "站姿啞鈴肩推"
            case .seatedBarbellPress: return "坐姿槓鈴肩推"
            case .seatedDumbbellPress: return "坐姿啞鈴肩推"
            case .machinePress: return "機械肩推"
            case .custom(let name): return name
        }
    }
}

public enum AbsExercise: Codable, Equatable {
    case machineCrunch
    case rotaryTorsoMachine
    case bodyweight
    case custom(String)

    static var builtInCases: [AbsExercise] {
        return [
            .machineCrunch,
            .rotaryTorsoMachine,
            .bodyweight,
        ]
    }

    public var name: String {
        switch self {
            case .machineCrunch: return "機械捲腹"
            case .rotaryTorsoMachine: return "腰部旋轉機"
            case .bodyweight: return "徒手"
            case .custom(let name): return name
        }
    }
}
