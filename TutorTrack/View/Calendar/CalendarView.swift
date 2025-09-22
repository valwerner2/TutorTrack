//
//  Calendar View.swift
//  TutorTrack
//
//  Created by Valentin Werner on 04.09.25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var pupils: [ClassModel]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Text("deine mudda")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(for: ClassModel.self) { navDest in
                Text("lol")
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newCalendarEntry = CalendarEntryModel()
            modelContext.insert(newCalendarEntry)
            path.append(newCalendarEntry)
        }
    }

    private func deleteItem(_ offsets: IndexSet, in letter: String) {
        withAnimation {
            
        }
    }
}
