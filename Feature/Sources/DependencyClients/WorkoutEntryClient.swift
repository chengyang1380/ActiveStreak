//  WorkoutEntryClient.swift
//  ActiveStreak
//
//  Created by Copilot on 2025/07/06.

import ComposableArchitecture
import Foundation
import Models
import SwiftData

public struct WorkoutEntryClient: Sendable {
    public var create: @Sendable (WorkoutEntryDTO) async throws -> PersistentIdentifier
    public var retrieve: @Sendable (WorkoutEntryQuery) async throws -> [WorkoutEntryDTO]
    public var update: @Sendable (PersistentIdentifier, WorkoutEntryDTO) async throws -> Bool
    public var delete: @Sendable (PersistentIdentifier) async throws -> Bool

    public init(
        create: @escaping @Sendable (WorkoutEntryDTO) async throws -> PersistentIdentifier,
        retrieve: @escaping @Sendable (WorkoutEntryQuery) async throws -> [WorkoutEntryDTO],
        update: @escaping @Sendable (PersistentIdentifier, WorkoutEntryDTO) async throws -> Bool,
        delete: @escaping @Sendable (PersistentIdentifier) async throws -> Bool
    ) {
        self.create = create
        self.retrieve = retrieve
        self.update = update
        self.delete = delete
    }
}

extension WorkoutEntryClient: DependencyKey {
    public static var liveValue: WorkoutEntryClient {
        let provider = WorkoutEntryProvider.shared
        let handlerCreator = provider.dataHandlerCreator()
        return WorkoutEntryClient(
            create: { dto in
                let handler = await handlerCreator()
                return try await handler.create(dto)
            },
            retrieve: { query in
                let handler = await handlerCreator()
                return try await handler.retrieve(query: query)
            },
            update: { id, dto in
                let handler = await handlerCreator()
                return try await handler.update(id: id, with: dto)
            },
            delete: { id in
                let handler = await handlerCreator()
                return try await handler.delete(id: id)
            }
        )
    }
}

public extension DependencyValues {
    var workoutEntryClient: WorkoutEntryClient {
        get { self[WorkoutEntryClient.self] }
        set { self[WorkoutEntryClient.self] = newValue }
    }
}
