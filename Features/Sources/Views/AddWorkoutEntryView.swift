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
    @FocusState private var isFocused: Bool

    package var body: some View {
        NavigationStack {
            Form {
                Section("Step 1 Muscle Group") {
                    Picker("", selection: $store.muscleGroupSelected) {
                        ForEach(store.state.muscleGroups, id: \.self) { group in
                            Text(group.rawValue)
                                .tag(Optional(group))
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                }

                Section("Step 2 Exercise") {
                    Picker("Exercise", selection: $store.exerciseNameSelected) {
                        Text("None")
                            .tag(nil as String?)
                        ForEach(store.state.exerciseNames, id: \.self) {
                            Text($0)
                                .tag($0)
                        }
                    }
                }

                Section("Step 3 Weight") {
                    TextField("Weight", text: $store.weight)
                        .focused($isFocused)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button("Save") {
                        store.send(.saveButtonTapped)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        isFocused = false
                    }
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
