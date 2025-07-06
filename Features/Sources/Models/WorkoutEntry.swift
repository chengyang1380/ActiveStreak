//
//  WorkoutEntry.swift
//  Features
//
//  Created by ChengYangChen on 6/8/25.
//

import Foundation
import SwiftData

public typealias CurrentWorkoutEntry = WorkoutEntryV1

public enum WorkoutEntryV1: VersionedSchema {
    public static var versionIdentifier: Schema.Version {
        .init(1, 0, 0)
    }

    public static var models: [any PersistentModel.Type] {
        [WorkoutEntry.self]
    }
}

public typealias WorkoutEntry = WorkoutEntryV1.WorkoutEntry

extension WorkoutEntryV1 {
    @Model
    public final class WorkoutEntry {
        @Attribute(.unique) public var id: UUID
        public var date: Date
        public var muscleGroup: String
        public var exerciseName: String
        public var weight: Double

        public init(
            id: UUID = UUID(),
            date: Date = .now,
            muscleGroup: String,
            exerciseName: String,
            weight: Double
        ) {
            self.id = id
            self.date = date
            self.muscleGroup = muscleGroup
            self.exerciseName = exerciseName
            self.weight = weight
        }

        public func toDTO() -> WorkoutEntryDTO {
            .init(
                id: id,
                date: date,
                muscleGroup: muscleGroup,
                exerciseName: exerciseName,
                weight: weight
            )
        }
    }
}

public struct WorkoutEntryDTO: Sendable, Equatable {
    public var id: UUID
    public var date: Date
    public var muscleGroup: String
    public var exerciseName: String
    public var weight: Double

    public init(
        id: UUID = UUID(),
        date: Date = .now,
        muscleGroup: String,
        exerciseName: String,
        weight: Double
    ) {
        self.id = id
        self.date = date
        self.muscleGroup = muscleGroup
        self.exerciseName = exerciseName
        self.weight = weight
    }
}
