//
//  File.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 7/6/25.
//

import DependencyClients
import Foundation
import Models
import SwiftData
import Testing

struct DataProivderTests {
    @MainActor
    @Test
    func create() async throws {
        let container = try ContainerForTest.temp(#function)
        let handler = DataHandler(modelContainer: container)
        let workoutEntry = WorkoutEntryDTO(
            date: Date(),
            muscleGroup: "chest",
            exerciseName: "bench press",
            weight: 100.0
        )
        let id = try await handler.create(workoutEntry)
        let fetchDescriptor = FetchDescriptor<WorkoutEntry>()
        let items = try container.mainContext.fetch(fetchDescriptor)
        let fetched = try #require(items.first)
        #expect(fetched.muscleGroup == "chest")
        #expect(fetched.exerciseName == "bench press")
        #expect(fetched.weight == 100.0)
        #expect(fetched.id == id)
    }

    @MainActor
    @Test
    func update() async throws {
        let container = try ContainerForTest.temp(#function)
        let handler = DataHandler(modelContainer: container)

        let id = UUID()
        let date = Date()
        let workoutEntry = WorkoutEntryDTO(
            id: id,
            date: date,
            muscleGroup: "chest",
            exerciseName: "bench press",
            weight: 100.0
        )
        try await handler.create(workoutEntry)

        let fetchDescriptor = FetchDescriptor<WorkoutEntry>()
        let items = try container.mainContext.fetch(fetchDescriptor)

        let firstItem = try #require(items.first)
        #expect(items.count == 1)
        #expect(firstItem.muscleGroup == "chest")
        #expect(firstItem.exerciseName == "bench press")
        #expect(firstItem.weight == 100.0)

        let workoutEntryUpdated = WorkoutEntryDTO(
            id: firstItem.id,
            date: date,
            muscleGroup: "back",
            exerciseName: "deadlift",
            weight: 120.0
        )
        try await handler.update(id: firstItem.id, with: workoutEntryUpdated)

        let itemsAgain = try container.mainContext.fetch(fetchDescriptor)
        let updatedItem = try #require(itemsAgain.first)
        #expect(itemsAgain.count == 1)
        #expect(updatedItem.muscleGroup == "back")
        #expect(updatedItem.exerciseName == "deadlift")
        #expect(updatedItem.weight == 120.0)
    }

    @MainActor
    @Test
    func delete() async throws {
        let container = try ContainerForTest.temp(#function)
        let handler = DataHandler(modelContainer: container)
        let workoutEntry = WorkoutEntryDTO(
            date: Date(),
            muscleGroup: "chest",
            exerciseName: "bench press",
            weight: 100.0
        )
        let id = try await handler.create(workoutEntry)
        let fetchDescriptor = FetchDescriptor<WorkoutEntry>()
        let items = try container.mainContext.fetch(fetchDescriptor)
        let fetched = try #require(items.first)
        #expect(fetched.muscleGroup == "chest")
        #expect(fetched.exerciseName == "bench press")
        #expect(fetched.weight == 100.0)
        #expect(fetched.id == id)


        let deleted = try await handler.delete(id: id)
        #expect(deleted)
        let itemsDelete = try container.mainContext.fetch(fetchDescriptor)
        #expect(itemsDelete.isEmpty)
    }
}
