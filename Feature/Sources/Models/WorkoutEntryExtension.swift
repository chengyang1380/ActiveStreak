//
//  WorkoutEntryExtension.swift
//  ActiveStreakPackage
//
//  Created by ChengYangChen on 7/12/25.
//

import Foundation
import SwiftData

// MARK: - Predicate Enum
public enum WorkoutEntryPredicate: Sendable {
    case filterByMuscleGroup(String)
    case filterByExerciseName(String)
    case filterByDateRange(Date, Date)
    case none
}

// MARK: - Sorting Enum
public enum WorkoutEntrySortingOption: Sendable {
    case orderByDateDesc
    case orderByDateAsc
    case orderByWeightDesc
    case orderByWeightAsc
    case orderByExerciseName
    case empty
}

// MARK: - Query Enum
public enum WorkoutEntryQuery: Sendable {
    case all(order: WorkoutEntrySortingOption)
    case byMuscleGroup(String, order: WorkoutEntrySortingOption)
    case byExerciseName(String, order: WorkoutEntrySortingOption)
    case byDateRange(Date, Date, order: WorkoutEntrySortingOption)
}

extension WorkoutEntry {
    public static func predicateFor(_ filter: WorkoutEntryPredicate)
        -> Predicate<WorkoutEntry>?
    {
        switch filter {
        case let .filterByMuscleGroup(muscleGroup):
            return #Predicate<WorkoutEntry> { $0.muscleGroup == muscleGroup }
        case let .filterByExerciseName(name):
            return #Predicate<WorkoutEntry> { $0.exerciseName == name }
        case let .filterByDateRange(start, end):
            return #Predicate<WorkoutEntry> {
                $0.date >= start && $0.date <= end
            }
        case .none:
            return nil
        }
    }

    public static func sortDescriptorsFor(_ option: WorkoutEntrySortingOption)
        -> [SortDescriptor<WorkoutEntry>]
    {
        switch option {
        case .orderByDateDesc:
            [SortDescriptor(\WorkoutEntry.date, order: .reverse)]
        case .orderByDateAsc:
            [SortDescriptor(\WorkoutEntry.date, order: .forward)]
        case .orderByWeightDesc:
            [SortDescriptor(\WorkoutEntry.weight, order: .reverse)]
        case .orderByWeightAsc:
            [SortDescriptor(\WorkoutEntry.weight, order: .forward)]
        case .orderByExerciseName:
            [SortDescriptor(\WorkoutEntry.exerciseName, order: .forward)]
        case .empty:
            []
        }
    }

    public static func fetchDescriptorForQuery(_ query: WorkoutEntryQuery)
        -> FetchDescriptor<WorkoutEntry>
    {
        switch query {
        case let .all(order):
            return FetchDescriptor<WorkoutEntry>(
                predicate: nil,
                sortBy: Self.sortDescriptorsFor(order)
            )
        case let .byMuscleGroup(muscleGroup, order):
            return FetchDescriptor<WorkoutEntry>(
                predicate: Self.predicateFor(.filterByMuscleGroup(muscleGroup)),
                sortBy: Self.sortDescriptorsFor(order)
            )
        case let .byExerciseName(name, order):
            return FetchDescriptor<WorkoutEntry>(
                predicate: Self.predicateFor(.filterByExerciseName(name)),
                sortBy: Self.sortDescriptorsFor(order)
            )
        case let .byDateRange(start, end, order):
            return FetchDescriptor<WorkoutEntry>(
                predicate: Self.predicateFor(.filterByDateRange(start, end)),
                sortBy: Self.sortDescriptorsFor(order)
            )
        }
    }
}
