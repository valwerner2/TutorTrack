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
    
    @State private var searchText = ""
    
    private var filteredPupils: [Pupil] {
        if searchText.isEmpty {
            print("is empty")
            return pupils
        } else {
            print("not")
            let temp = pupils.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            return temp.isEmpty ? pupils : temp
        }
    }
    
    private var groupedPupils: [String: [Pupil]] {
        print("grouping")
        return Dictionary(
            grouping: filteredPupils.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        ) { pupil in
            String(pupil.name.prefix(1)).uppercased()
        }
    }
    
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
            
            Button("show all") {
                showSheet = true
            }

            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    List {
                        ForEach(groupedPupils.keys.sorted(), id: \.self) { letter in
                            Section(header: Text(letter)) {
                                ForEach(groupedPupils[letter] ?? []) { pupil in
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
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
                    .navigationTitle("Pupils")
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
