//
//  BlockerView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.09.25.
//

import SwiftUI


struct BlockerView: View {
    let blocker: BlockerModel
    
    @State private var editingBlocker = BlockerModel()
    @Environment(\.editMode) private var editMode
    @FocusState private var titleFieldIsFocused: Bool
    
    var body: some View {
        List {
            Section(
                header:
                    Text("Basic Data")
                    .font(.headline)
                    .textCase(nil)
            ) {
                if editMode?.wrappedValue.isEditing == true {
                    HStack {
                        Text("Title").bold()
                        Spacer()
                        TextField("Title", text: $editingBlocker.title)
                            .focused($titleFieldIsFocused)
                    }
                }
                HStack {
                    Text("Note").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Note", text: $editingBlocker.note)
                    } else {
                        Text(blocker.title.isEmpty ? "-" : blocker.title)
                    }
                }
            }
            Section(
                header:
                    Text("Date")
                    .font(.headline)
                    .textCase(nil)
            ){
                DateIntervalPicker(interval: $editingBlocker.dateInterval)
            }
        }
        .navigationTitle(blocker.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .onAppear {
            editingBlocker = blocker
            if blocker.title.isEmpty
            {
                editMode?.wrappedValue = .active
                DispatchQueue.main.async {
                    titleFieldIsFocused = true
                }
            }
        }
    }
}
