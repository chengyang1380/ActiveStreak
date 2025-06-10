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
            Text( /*@START_MENU_TOKEN@*/"Hello, World!" /*@END_MENU_TOKEN@*/)
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
