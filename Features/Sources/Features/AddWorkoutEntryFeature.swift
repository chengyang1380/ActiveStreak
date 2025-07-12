//
//  AddWorkoutEntryFeature.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import DependencyClients
import Foundation
import Models

@Reducer
package struct AddWorkoutEntryFeature {
    @ObservableState
    package struct State: Equatable {
        package var muscleGroups = MuscleGroup.allCases
        package var muscleGroupSelected: MuscleGroup? = nil
        package var exerciseNames: [String] = []
        package var exerciseNameSelected: String?
        package var weight: String = ""
        package var toastMessage: String?
        package init() {}
    }

    package enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case moscleGroupChanged
        case saveButtonTapped
        case dismissToast
        case inputError
        case saveSuccess
    }

    @Dependency(\.workoutEntryClient) var workoutEntryClient
    @Dependency(\.dismiss) var dismiss

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
            guard let muscleGroup = state.muscleGroupSelected?.rawValue,
                let exerciseName = state.exerciseNameSelected,
                let weight = Double(state.weight)
            else {
                return .send(.inputError)
            }
            return .run { send in
                let _ = try await workoutEntryClient.create(
                    WorkoutEntryDTO.init(
                        muscleGroup: muscleGroup,
                        exerciseName: exerciseName,
                        weight: weight
                    )
                )
                await send(.saveSuccess)
            }

        case .binding:
            return .none

        case .dismissToast:
            state.toastMessage = nil
            return .none

        case .inputError:
            state.toastMessage = "Error"
            return .run { send in
                try await Task.sleep(for: .seconds(2))
                await send(.dismissToast)
            }

        case .saveSuccess:
            state.toastMessage = "Successfully saved!"
            return .run { _ in
                await self.dismiss()
            }
        }
    }
}

extension AddWorkoutEntryFeature {
    private func updateExerciseNames(
        _ state: inout AddWorkoutEntryFeature.State
    ) {
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
