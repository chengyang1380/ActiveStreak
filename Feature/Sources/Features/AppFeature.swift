//
//  AppFeature.swift
//  Features
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import Models

@Reducer
package struct AppFeature {
    @ObservableState
    package struct State: Equatable {
        package var home = HomeFeature.State()
        package init() {}
    }

    package enum Action: Equatable {
        case home(HomeFeature.Action)
        case task
    }

    package init() {}

    package var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Reduce(core)
    }

    package func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .home:
            return .none
        case .task:
            return .none
        }
    }
}
