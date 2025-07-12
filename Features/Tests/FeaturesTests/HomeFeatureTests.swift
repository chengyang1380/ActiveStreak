import ComposableArchitecture
import Foundation
import Models
import Testing

@testable import Features

@MainActor
struct HomeFeatureTests {
    @Test
    func addWorkoutRefreshesListOnDismiss() async {
        let store = TestStore(
            initialState: HomeFeature.State()
        ) {
            HomeFeature()
        } withDependencies: {
            $0.workoutEntryClient.retrieve = { [] }
        }

        await store.send(.addButtonTapped) {
            $0.destination = .add(AddWorkoutEntryFeature.State())
        }

        let expectedWorkoutEntry = WorkoutEntryDTO(
            id: UUID(),
            date: .now,
            muscleGroup: "Chest",
            exerciseName: "Push Up",
            weight: 20
        )

        store.dependencies.workoutEntryClient.retrieve = { @Sendable in
            return [expectedWorkoutEntry]
        }

        await store.send(.destination(.dismiss)) {
            $0.destination = nil
        }

        await store.receive(\.task) {
            $0.isLoading = true
        }

        await store.receive(\.updateList) {
            $0.isLoading = false
            $0.workoutEntries = [expectedWorkoutEntry]
        }
    }
}
