//
//  TutorTrackApp.swift
//  TutorTrack
//
//  Created by Valentin Werner on 21.08.25.
//

import SwiftUI
import SwiftData

@main
struct TutorTrackApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PupilModel.self,
            TransactionModel.self,
            CalendarEntryModel.self,
            ClassModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
