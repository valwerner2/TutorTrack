//
//  PupilDetailView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 21.08.25.
//

import SwiftUI

struct PupilDetailView: View {
    let pupil: Pupil
    
    @State private var editingPupil = Pupil()
    @Environment(\.editMode) private var editMode
    @FocusState private var nameFieldIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(pupil.name)
                .font(.largeTitle)
            
            
            
            List {
                if editMode?.wrappedValue.isEditing == true {
                    HStack {
                        Text("Name").bold()
                        Spacer()
                        TextField("Name", text: $editingPupil.name)
                            .focused($nameFieldIsFocused)
                    }
                }
                
                HStack {
                    Text("E-Mail").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("E-Mail", text: $editingPupil.email)
                    } else {
                        Text(pupil.email.isEmpty ? "-" : pupil.email)
                    }
                }
                HStack {
                    Text("Phone").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Phone", text: $editingPupil.phone)
                    } else {
                        Text(pupil.phone.isEmpty ? "-" : pupil.phone)
                    }
                }
                HStack {
                    Text("Parent-Phone").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Parent-Phone", text: $editingPupil.phoneParent)
                    } else {
                        Text(pupil.phoneParent.isEmpty ? "-" : pupil.phoneParent)
                    }
                }
                HStack {
                    Text("Hourly Rate").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Hourly Rate",
                                  text: Binding(
                                    get: { String(editingPupil.hourlyRate) },
                                    set: { editingPupil.hourlyRate = Double($0) ?? 0 }
                                  )
                        )
                        .keyboardType(.decimalPad)
                    } else {
                        Text(String(pupil.hourlyRate))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .onAppear {
                editingPupil = pupil
                if pupil.name.isEmpty
                {
                    editMode?.wrappedValue = .active
                    DispatchQueue.main.async {
                        nameFieldIsFocused = true
                    }
                }
            }
            
        }
    }
}

#Preview {
    //PupilDetailView(pupil: Pupil(name: "sf", email: "sdf", phone: "222", phoneParent: "aaa", hourlyRate: 187))
    PupilDetailView(pupil: Pupil())
}
