//
//  ClassView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.09.25.
//

import SwiftUI


struct ClassView: View {
    @Bindable var classModel: ClassModel
    
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
                        TextField("Title", text: $classModel.title)
                            .focused($titleFieldIsFocused)
                    }
                }
                HStack {
                    Text("Note").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Note", text: $classModel.note)
                    } else {
                        Text(classModel.title.isEmpty ? "-" : classModel.title)
                    }
                }
            }
            Section(
                header:
                    Text("Date")
                    .font(.headline)
                    .textCase(nil)
            ){
                DateIntervalPicker(interval: $classModel.dateInterval)
            }
            Section(
                header:
                    Text("Person")
                    .font(.headline)
                    .textCase(nil)
            ){
                PupilPickerView(pupil: $classModel.pupilModel, suggested: [])
            }
        }
        .navigationTitle(classModel.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .onAppear {
            if classModel.title.isEmpty
            {
                editMode?.wrappedValue = .active
                DispatchQueue.main.async {
                    titleFieldIsFocused = true
                }
            }
        }
    }
}
