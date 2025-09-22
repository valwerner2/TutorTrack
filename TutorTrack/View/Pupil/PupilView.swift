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
    @Query private var pupils: [PupilModel]
    
    @State private var path = NavigationPath()
    @State private var searchText = ""
    
    private var filteredPupils: [PupilModel] {
        if searchText.isEmpty {
            return pupils
        } else {
            let temp = pupils.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            return temp.isEmpty ? pupils : temp
        }
    }
    
    private var groupedPupils: [String: [PupilModel]] {
        return Dictionary(
            grouping: filteredPupils.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        ) { pupil in
            String(pupil.name.prefix(1)).uppercased()
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(groupedPupils.keys.sorted(), id: \.self) { letter in
                    Section(header: Text(letter)) {
                        ForEach(groupedPupils[letter] ?? []) { pupil in
                            NavigationLink {
                                PupilDetailView(pupil: pupil)
                            } label: {
                                Text(pupil.name)
                            }
                        }
                        .onDelete { offsets in
                            deleteItem(offsets, in: letter)
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
            .navigationTitle("People")
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
            .navigationDestination(for: PupilModel.self) { pupil in
                PupilDetailView(pupil: pupil)
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newPupil = PupilModel()
            modelContext.insert(newPupil)
            path.append(newPupil)
        }
    }

    private func deleteItem(_ offsets: IndexSet, in letter: String) {
        withAnimation {
            if let group = groupedPupils[letter] {
                for index in offsets {
                    let pupilToDelete = group[index]
                    modelContext.delete(pupilToDelete)
                }
            }
        }
    }
}

#Preview {
    PupilView()
        .modelContainer(for: PupilModel.self, inMemory: true)
}
