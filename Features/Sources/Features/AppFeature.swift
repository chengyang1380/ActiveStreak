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

        package init() {}
    }

    package enum Action: Equatable {
        case task
    }

    package init() {}

    package var body: some ReducerOf<Self> {
        Reduce(core)
    }

    package func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .task:
            return .none
        }
    }
}
