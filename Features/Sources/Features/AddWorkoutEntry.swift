//
//  AddWorkoutEntry.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import Foundation
import Models

@Reducer
package struct AddWorkoutEntryFeature: Equatable {
    @ObservableState
    package struct State: Equatable {
        package var muscleGroups = MuscleGroupVM.allCases
        package var muscleGroupSelectedString: String = ""//MuscleGroupVM = .chest
        package init() {}
    }

    package enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case moscleGroupChanged(MuscleGroupVM)
    }

    package init() {}

    package var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce(core)
    }

    package func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
            case .binding(\.muscleGroupSelectedString):
                return .send(.moscleGroupChanged(.init(rawValue: state.muscleGroupSelectedString)!))
            case let .moscleGroupChanged(group):
                return .none
            case .binding:
                return .none
        }
    }
}

extension AddWorkoutEntryFeature {
//    var muscleGroupSelectedString: String {
//        get {
//
//        }
//    }
}

 extension AddWorkoutEntryFeature {
     package enum MuscleGroupVM: String, Identifiable, CaseIterable, Equatable {
         package var id: String { rawValue }

        case chest
        case back
        case legs
        case biceps
        case triceps
        case shoulders
        case abs
    }
}
