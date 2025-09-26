//
//  TransactionDetailView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//


import SwiftUI
import SwiftData

struct TransactionDetailView: View {
    @Bindable var transaction: TransactionModel
    let update: (() -> Void)?
    
    @Environment(\.editMode) private var editMode
    @FocusState private var amountFieldFocused: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query private var pupils: [PupilModel]
    
    var body: some View {
        List {
            Section(
                header:
                    Text("Person")
                    .font(.headline)
                    .textCase(nil)
            ) {
                PupilPickerView(pupil: $transaction.pupil, suggested: []) //Array(pupils[0..<2]))
            }
            Section(
                header:
                    Text("Payment")
                    .font(.headline)
                    .textCase(nil)
            ) {
                HStack {
                    Text("Amount").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Amount", value: $transaction.amount, format: .number
                        )
                        .keyboardType(.decimalPad)
                        .focused($amountFieldFocused)
                    } else {
                        Text(String(transaction.amount))
                    }
                }
                HStack {
                    Text("Type").bold()
                    Spacer()
                    if transaction.isBankTransfer != nil {
                        if editMode?.wrappedValue.isEditing == true {
                            Toggle("Bank Transfer", isOn: Binding(
                                get: { transaction.isBankTransfer! },
                                set: { transaction.isBankTransfer = $0 }
                            ))
                        }
                        else if let isBankTransfer = transaction.isBankTransfer {
                            Text(isBankTransfer ? "Bank Transfer" : "Cash")
                        }
                    }
                    else {
                        Text("Automatically generated")
                    }
                }
            }
            Section(
                header:
                    Text("Linked Class")
                    .font(.headline)
                    .textCase(nil)
            ) {
                
            }
            Section(
                header:
                    Text("Date")
                    .font(.headline)
                    .textCase(nil)
            ) {
                if editMode?.wrappedValue.isEditing == true {
                    DatePicker(
                        "Start Date",
                        selection: $transaction.date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                }else{
                    Text(transaction.date, format: .dateTime.day().month().year())
                }
            }
            Section(
                header:
                    Text("Additional Info")
                    .font(.headline)
                    .textCase(nil)
            ) {
                if editMode?.wrappedValue.isEditing == true {
                    HStack {
                        Text("Title").bold()
                        Spacer()
                        TextField("Title", text: $transaction.title)
                    }
                }
                
                HStack {
                    Text("Note").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Note", text: $transaction.note)
                    } else {
                        Text(transaction.note.isEmpty ? "-" : transaction.note)
                    }
                }
            }
            
        }
        .navigationTitle(transaction.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .onAppear {
            if transaction.title.isEmpty
            {
                editMode?.wrappedValue = .active
                DispatchQueue.main.async {
                    amountFieldFocused = true
                }
            }
        }
        .onDisappear(){
            update?()
        }
    }
}
