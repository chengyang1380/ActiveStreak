//
//  PublicApp.swift
//  Features
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import SwiftUI
import Views
import Features

@main
public struct PublicApp: App {
    public init() {}

    public var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppFeature.State(),
                    reducer: { AppFeature() }
                )
            )
        }
    }
}
