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
        package var muscleGroups = MuscleGroup.allCases
        package var muscleGroupSelected: MuscleGroup? = nil
        package var exerciseNames: [String] = []
        package var exerciseNameSelected: String = ""
        package var weight: String = ""
        package init() {}
    }

    package enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case moscleGroupChanged
        case saveButtonTapped
    }

    package init() {}

    package var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce(core)
    }

    package func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .binding(\.muscleGroupSelected):
            return .send(.moscleGroupChanged)
        case .moscleGroupChanged:
            updateExerciseNames(&state)
            return .none
        case .saveButtonTapped:
            return .none
        case .binding:
            return .none
        }
    }
}

extension AddWorkoutEntryFeature {
    private func updateExerciseNames(_ state: inout AddWorkoutEntryFeature.State) {
        guard let group = state.muscleGroupSelected else {
            return
        }
        var result = [String]()
        switch group {
        case .chest:
            result = ChestExercise.allCases.map { $0.name }
        case .back:
            result = BackExercise.allCases.map { $0.name }
        case .legs:
            result = LegExercise.allCases.map { $0.name }
        case .biceps:
            result = BicepsExercise.allCases.map { $0.name }
        case .triceps:
            result = TricepsExercise.allCases.map { $0.name }
        case .shoulders:
            result = ShouldersExercise.allCases.map { $0.name }
        case .abs:
            result = AbsExercise.allCases.map { $0.rawValue }
        }
        state.exerciseNames = result
    }
}
