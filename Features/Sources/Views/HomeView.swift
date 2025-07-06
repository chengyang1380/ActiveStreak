//
//  HomeView.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 6/8/25.
//

import ComposableArchitecture
import Features
import SwiftUI

package struct HomeView: View {

    @Bindable package var store: StoreOf<HomeFeature>

    package var body: some View {
        NavigationStack {
            List(store.workoutEntries, id: \.id) { entry in
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.exerciseName)
                        .font(.headline)
                    Text(entry.muscleGroup)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    HStack {
                        Text("重量：\(entry.weight, specifier: "%.1f") kg")
                        Spacer()
                        Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle(Text("Summary"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(
                item: $store.scope(
                    state: \.destination?.add,
                    action: \.destination.add
                )
            ) { addStore in
                AddWorkoutEntryView(store: addStore)
            }
        }
        .task {
            store.send(.task)
        }
    }
}

#Preview {
    HomeView(
        store: .init(
            initialState: HomeFeature.State(),
            reducer: {
                HomeFeature()
            }
        )
    )
}
