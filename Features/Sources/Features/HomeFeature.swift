//
//  HomeFeature.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import Foundation

@Reducer
package struct HomeFeature {
    @ObservableState
    package struct State: Equatable {
        @Presents package var destination: Destination.State?

        package init() {}
    }

    package enum Action: Equatable {
        case addButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }

    package init() {}

    package var body: some ReducerOf<Self> {
        Reduce(core)
            .ifLet(\.$destination, action: \.destination) {
                Destination.body
            }
    }

    package func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
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
    package enum Destination: Equatable {
        case add(AddWorkoutEntryFeature)
    }
}

//package extension HomeFeature.Destination: Equatable {}
