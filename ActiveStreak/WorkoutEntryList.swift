//
//  WorkoutEntryList.swift
//  ActiveStreak
//
//  Created by ChengYangChen on 2/23/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct WorkoutEntryList {

    @ObservableState
    struct State: Equatable {
        @Shared(.workoutEntry) var workoutEntries
    }

    enum Action {
        case addWorkoutEnttryButtonTapped
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addWorkoutEnttryButtonTapped:
                return .none
            }
        }
    }
}

struct WorkoutEntryListView: View {

    @Bindable var store: StoreOf<WorkoutEntryList>

    var body: some View {
        List {
            ForEach(Array(store.$workoutEntries)) { $workoutEntry in
                WorkoutEntryCardView(workoutEntry: workoutEntry)
            }
        }
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "plus")
            }
        }
        .navigationTitle("ActiveStreak - Workout Entries")
    }
}

struct WorkoutEntryCardView: View {
    let workoutEntry: WorkoutEntry

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "flame.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(workoutEntry.exercise.name)
                    .font(.title)
            }

            Spacer()

            HStack {
                Label {
                    Text(String(format: "%.1f kg", workoutEntry.weight))
                } icon: {
                    Image(systemName: "figure.mind.and.body.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text("\(workoutEntry.sets) 組")
                Text("每組 \(workoutEntry.reps) 下")
            }
            .font(.callout)
        }
        .padding()
    }
}

#Preview("List") {
    @Shared(.workoutEntry) var workoutEntries = [
        .mock
    ]

    WorkoutEntryListView(
        store: Store(
            initialState: WorkoutEntryList.State(),
            reducer: {
                WorkoutEntryList()
            }
        )
    )
}

#Preview("Card") {
    WorkoutEntryCardView(workoutEntry: .mock)
}

extension SharedKey
where Self == FileStorageKey<IdentifiedArrayOf<WorkoutEntry>>.Default {
    static var workoutEntry: Self {
        Self[
            .fileStorage(
                .documentsDirectory.appending(component: "workoutEntries.json")),
            default: []]
    }
}
