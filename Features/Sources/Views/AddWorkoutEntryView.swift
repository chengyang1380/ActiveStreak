//
//  File.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import Features
import Foundation
import SwiftUI

package struct AddWorkoutEntryView: View {

    @Bindable package var store: StoreOf<AddWorkoutEntryFeature>

    package var body: some View {
        NavigationStack {
            Form {
                Section("Step 1 Muscle Group") {
                    Picker("", selection: $store.muscleGroupSelectedString) {
                        ForEach(store.state.muscleGroups, id: \.rawValue) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                }
            }
            .navigationTitle(Text("Add Wrokout Entry"))
        }
    }
}

#Preview {
    AddWorkoutEntryView(
        store: .init(
            initialState: AddWorkoutEntryFeature.State(),
            reducer: {
                AddWorkoutEntryFeature()
            }
        )
    )
}
