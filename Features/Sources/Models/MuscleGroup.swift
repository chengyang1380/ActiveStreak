//
//  MuscleGroup.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import Foundation

public enum MuscleGroup: String, Identifiable, CaseIterable, Equatable {
    public var id: String { rawValue }

    case chest
    case back
    case legs
    case biceps
    case triceps
    case shoulders
    case abs
}


public enum ChestExercise: String, Codable, Equatable, CaseIterable {
    case barbellBenchPress
    case dumbbellBenchPress
    case dumbbellInclineBenchPress
    case machineBenchPress
    case machinePecDeck
    case cablePecDeck
    case smithMachineBenchPress
    case smithMachineInclineBenchPress

    public var name: String {
        switch self {
            case .barbellBenchPress: return "Barbell Bench Press (槓鈴臥推)"
            case .dumbbellBenchPress: return "Dumbbell Bench Press (啞鈴臥推)"
            case .dumbbellInclineBenchPress: return "Dumbbell Incline Bench Press (啞鈴上斜臥推)"
            case .machineBenchPress: return "Machine Bench Press (機械臥推)"
            case .machinePecDeck: return "Machine Pec Deck (機械夾胸)"
            case .cablePecDeck: return "Cable Pec Deck (Cable 夾胸)"
            case .smithMachineBenchPress: return "Smith Machine Bench Press (施密斯機臥推)"
            case .smithMachineInclineBenchPress: return "Smith Machine Incline Bench Press (施密斯上斜臥推)"
        }
    }
}


public enum BackExercise: String, Codable, Equatable, CaseIterable {
    case pullUp
    case barbellRow
    case dumbbellRow
    case latPulldownNew
    case latPulldownOld
    case seatedRowNew
    case seatedRowOld

    public var name: String {
        switch self {
            case .pullUp: return "Pull Up (引體向上)"
            case .barbellRow: return "Barbell Row (槓鈴划船)"
            case .dumbbellRow: return "Dumbbell Row (啞鈴划船)"
            case .latPulldownNew: return "Lat Pulldown - New (滑輪下拉（新）)"
            case .latPulldownOld: return "Lat Pulldown - Old (滑輪下拉（舊）)"
            case .seatedRowNew: return "Seated Row - New (坐姿划船（新）)"
            case .seatedRowOld: return "Seated Row - Old (坐姿划船（舊）)"
        }
    }
}


public enum LegExercise: String, Codable, Equatable, CaseIterable {
    case barbellSquat
    case barbellDeadlift
    case barbellSplitSquat
    case dumbbellSplitSquat
    case trapBarDeadlift
    case legPressNew
    case legPressOld
    case legCurlMachine
    case legExtensionMachine

    public var name: String {
        switch self {
            case .barbellSquat: return "Barbell Squat (槓鈴深蹲)"
            case .barbellDeadlift: return "Barbell Deadlift (槓鈴硬舉)"
            case .barbellSplitSquat: return "Barbell Split Squat (槓鈴分腿蹲)"
            case .dumbbellSplitSquat: return "Dumbbell Split Squat (啞鈴分腿蹲)"
            case .trapBarDeadlift: return "Trap Bar Deadlift (六角槓硬舉)"
            case .legPressNew: return "Leg Press - New (腿推機（新）)"
            case .legPressOld: return "Leg Press - Old (腿推機（舊）)"
            case .legCurlMachine: return "Leg Curl Machine (腿後屈伸機)"
            case .legExtensionMachine: return "Leg Extension Machine (腿前屈伸機)"
        }
    }
}

public enum BicepsExercise: String, Codable, Equatable, CaseIterable {
    case dumbbellCurl
    case barbellCurl
    case machineCurl

    public var name: String {
        switch self {
            case .dumbbellCurl: return "Dumbbell Curl (啞鈴彎舉)"
            case .barbellCurl: return "Barbell Curl (槓鈴彎舉)"
            case .machineCurl: return "Machine Curl (機械彎舉)"
        }
    }
}


public enum TricepsExercise: String, Codable, Equatable, CaseIterable {
    case machineExtension
    case dumbbellOverheadExtension
    case cablePushdown

    public var name: String {
        switch self {
            case .machineExtension: return "Machine Triceps Extension (機械三頭屈伸)"
            case .dumbbellOverheadExtension: return "Dumbbell Overhead Extension (啞鈴頸後臂屈伸)"
            case .cablePushdown: return "Cable Triceps Pushdown (Cable 機三頭肌下推)"
        }
    }
}

public enum ShouldersExercise: String, Codable, Equatable, CaseIterable {
    case lateralRaise
    case standingBarbellPress
    case standingDumbbellPress
    case seatedDumbbellPress
    case machinePress

    public var name: String {
        switch self {
            case .lateralRaise: return "Lateral Raise (側平舉)"
            case .standingBarbellPress: return "Standing Barbell Press (站姿槓鈴肩推)"
            case .standingDumbbellPress: return "Standing Dumbbell Press (站姿啞鈴肩推)"
            case .seatedDumbbellPress: return "Seated Dumbbell Press (坐姿啞鈴肩推)"
            case .machinePress: return "Machine Shoulder Press (機械肩推)"
        }
    }
}

public enum AbsExercise: String, Codable, Equatable, CaseIterable {
    case machineCrunch
    case rotaryTorsoMachine

    public var name: String {
        switch self {
            case .machineCrunch: return "Machine Crunch (機械捲腹)"
            case .rotaryTorsoMachine: return "Rotary Torso Machine (腰部旋轉機)"
        }
    }
}
