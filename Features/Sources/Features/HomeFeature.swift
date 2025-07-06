//
//  HomeFeature.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import Foundation
import Models

@Reducer
package struct HomeFeature {
    @ObservableState
    package struct State: Equatable {
        @Presents package var destination: Destination.State?
        package var workoutEntries: [WorkoutEntryDTO] = []
        package init() {}
    }

    package enum Action: Equatable {
        case task
        case updateList([WorkoutEntryDTO])
        case addButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }

    @Dependency(\.workoutEntryClient) var workoutEntryClient

    package init() {}

    package var body: some ReducerOf<Self> {
        Reduce(core)
            .ifLet(\.$destination, action: \.destination) {
                Destination.body
            }
    }

    package func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .task:
            return .run { send in
                let items = try await workoutEntryClient.retrieve()
                await send(.updateList(items))
            }

        case let .updateList(items):
            state.workoutEntries = items
            return .none

        case .addButtonTapped:
            state.destination = .add(AddWorkoutEntryFeature.State())
            return .none

        case .destination:
            return .none
        }
    }
}

extension HomeFeature {
    @Reducer(state: .equatable, action: .equatable)
    package enum Destination {
        case add(AddWorkoutEntryFeature)
    }
}

//package extension HomeFeature.Destination: Equatable {}
