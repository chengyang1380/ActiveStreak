//
//  ContainerForTest.swift
//  ActiveStreakPackage
//
//  Created by ChengYang on 7/6/25.
//

import Foundation
import SwiftData
import Models

enum ContainerForTest {
    static func temp(_ name: String, delete: Bool = true) throws
        -> ModelContainer
    {
        let url = URL.temporaryDirectory.appending(component: name)
        if delete, FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
        let schema = Schema(CurrentWorkoutEntry.models)
        let configuration = ModelConfiguration(url: url)
        let container = try! ModelContainer(
            for: schema,
            configurations: configuration
        )
        return container
    }
}
