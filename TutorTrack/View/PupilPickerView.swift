//
//  PupilPickerView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 25.08.25.
//

import SwiftUI
import SwiftData

struct PupilPickerView: View {
    let transaction: TransactionModel
    let suggested: [Pupil]
    
    @Environment(\.modelContext) private var modelContext
    @Query private var pupils: [Pupil]
    
    @State private var editingTransaction = TransactionModel()
    @State private var showSheet = false
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        if editMode?.wrappedValue.isEditing == true {
            if let selectedPupil = transaction.pupil{
                if !suggested.contains(selectedPupil)
                {
                    HStack{
                        Text(selectedPupil.name)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
            ForEach(suggested) { pupil in
                HStack {
                    Text(pupil.name)
                    Spacer()
                    if let selectedPupil = transaction.pupil{
                        if selectedPupil == pupil{
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    transaction.pupil = pupil
                }
            }
            
            Button("Select other") {
                showSheet = true
            }
                

            .sheet(isPresented: $showSheet) {
                List{
                    ForEach(pupils) { pupil in
                        HStack {
                            Text(pupil.name)
                            Spacer()
                            if transaction.pupil == pupil {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            transaction.pupil = pupil
                        }
                    }
                }
            }
        }
        else if let pupilToShow = transaction.pupil {
            HStack {
                Text("Name").bold()
                Spacer()
                Text(pupilToShow.name)
            }
            HStack {
                Text("E-Mail").bold()
                Spacer()
                Text(pupilToShow.email.isEmpty ? "-" : pupilToShow.email)
            }
            HStack {
                Text("Phone").bold()
                Spacer()
                Text(pupilToShow.phone.isEmpty ? "-" : pupilToShow.phone)
            
            }
            HStack {
                Text("Parent-Phone").bold()
                Spacer()
                Text(pupilToShow.phoneParent.isEmpty ? "-" : pupilToShow.phoneParent)
                
            }
            HStack {
                Text("Hourly Rate").bold()
                Spacer()
                Text(String(pupilToShow.hourlyRate))
            }
        }
        else{
            Text("No person selected!")
                .bold()
        }
        
    }
}
