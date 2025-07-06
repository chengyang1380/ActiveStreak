//
//  File.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import Features
import Foundation
import Models
import SwiftUI

package struct AddWorkoutEntryView: View {

    @Bindable package var store: StoreOf<AddWorkoutEntryFeature>
    @FocusState private var isFocused: Bool

    package var body: some View {
        NavigationStack {
            Form {
                Section("Step 1 Muscle Group") {
                    Picker("", selection: $store.muscleGroupSelected) {
                        Text("None")
                            .tag(nil as MuscleGroup?)
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
                                .tag(Optional($0))
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
            .overlay(
                Group {
                    if let message = store.state.toastMessage {
                        ToastView(message: message)
                            .transition(
                                .move(edge: .top)
                                    .combined(with: .opacity)
                            )
                            .zIndex(1)
                    }
                }
            )
        }
    }
}

private struct ToastView: View {
    let message: String
    var body: some View {
        Text(message)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .shadow(radius: 8)
            .padding(.top, 40)
            .foregroundColor(.primary)
            .font(.headline)
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
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
