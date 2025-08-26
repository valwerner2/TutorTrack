//
//  ContactsView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 21.08.25.
//

import SwiftUI
import SwiftData

struct PupilView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var pupils: [Pupil]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(pupils) { currentPupil in
                    NavigationLink {
                        PupilDetailView(pupil: currentPupil)
                    } label: {
                        Text(currentPupil.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("People")
            .navigationBarTitleDisplayMode(.inline)
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
            .navigationDestination(for: Pupil.self) { pupil in
                PupilDetailView(pupil: pupil)
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newPupil = Pupil()
            modelContext.insert(newPupil)
            path.append(newPupil)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(pupils[index])
            }
        }
    }
}

#Preview {
    PupilView()
        .modelContainer(for: Pupil.self, inMemory: true)
}
