//  WorkoutEntryProvider.swift
//  ActiveStreak
//
//  Created by Copilot on 2025/07/06.

import ComposableArchitecture
import Foundation
import Models
import SwiftData
import SwiftUICore

public final class WorkoutEntryProvider: Sendable {
    public static let shared = WorkoutEntryProvider()

    public let sharedModelContainer: ModelContainer = {
        let schema = Schema(CurrentWorkoutEntry.models)
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    public let previewContainer: ModelContainer = {
        let schema = Schema(CurrentWorkoutEntry.models)
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    public func dataHandlerCreator(preview: Bool = false) -> @Sendable () async
        -> DataHandler
    {
        let container = preview ? previewContainer : sharedModelContainer
        return { DataHandler(modelContainer: container) }
    }

    public init() {}
}

public struct DataHandlerKey: EnvironmentKey {
    public static let defaultValue: @Sendable () async -> DataHandler? = { nil }
}

extension EnvironmentValues {
    public var createDataHandler: @Sendable () async -> DataHandler? {
        get { self[DataHandlerKey.self] }
        set { self[DataHandlerKey.self] = newValue }
    }
}

@ModelActor
public actor DataHandler {
    @discardableResult
    public func create(_ dto: WorkoutEntryDTO) throws -> PersistentIdentifier {
        let item = WorkoutEntry(
            id: dto.id,
            date: dto.date,
            muscleGroup: dto.muscleGroup,
            exerciseName: dto.exerciseName,
            weight: dto.weight
        )
        modelContext.insert(item)
        try modelContext.save()
        return item.persistentModelID
    }

    public func retrieve(query: WorkoutEntryQuery = .all(order: .orderByDateDesc)) async throws -> [WorkoutEntryDTO] {
        let descriptor = WorkoutEntry.fetchDescriptorForQuery(query)
        let results = try modelContext.fetch(descriptor)
        return results.map { $0.toDTO() }
    }

    @discardableResult
    public func update(id: PersistentIdentifier, with dto: WorkoutEntryDTO)
        throws -> Bool
    {
        guard let item = self[id, as: WorkoutEntry.self] else { return false }
        item.date = dto.date
        item.muscleGroup = dto.muscleGroup
        item.exerciseName = dto.exerciseName
        item.weight = dto.weight
        try modelContext.save()
        return true
    }

    @discardableResult
    public func delete(id: PersistentIdentifier) throws -> Bool {
        guard let item = self[id, as: WorkoutEntry.self] else { return false }
        modelContext.delete(item)
        try modelContext.save()
        return true
    }
}
