//
//  TransactionDetailView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//


import SwiftUI
import SwiftData

struct TransactionDetailView: View {
    let transaction: TransactionModel
    let update: () -> Void
    
    @State private var editingTransaction = TransactionModel()
    @Environment(\.editMode) private var editMode
    @FocusState private var nameFieldIsFocused: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query private var pupils: [PupilModel]
    
    var body: some View {
        VStack(spacing: 0) {
            Text(transaction.title)
                .font(.largeTitle)
            
            List {
                Section(
                    header:
                        Text("Person")
                        .font(.headline)
                        .textCase(nil)
                ) {
                    PupilPickerView(transaction: transaction, suggested: Array(pupils[0..<2]))
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
                            TextField("Amount", value: $editingTransaction.amount, format: .number
                            )
                            .keyboardType(.decimalPad)
                        } else {
                            Text(String(transaction.amount))
                        }
                    }
                    HStack {
                        Text("Type").bold()
                        Spacer()
                        if editingTransaction.isBankTransfer != nil {
                            if editMode?.wrappedValue.isEditing == true {
                                Toggle("Bank Transfer", isOn: Binding(
                                    get: { editingTransaction.isBankTransfer! },
                                    set: { editingTransaction.isBankTransfer = $0 }
                                ))
                            }
                            else if let isBankTransfer = editingTransaction.isBankTransfer {
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
                        Text("Additional Info")
                        .font(.headline)
                        .textCase(nil)
                ) {
                    if editMode?.wrappedValue.isEditing == true {
                        HStack {
                            Text("Name").bold()
                            Spacer()
                            TextField("Name", text: $editingTransaction.title)
                                .focused($nameFieldIsFocused)
                        }
                    }
                    
                    HStack {
                        Text("Note").bold()
                        Spacer()
                        if editMode?.wrappedValue.isEditing == true {
                            TextField("Note", text: $editingTransaction.note)
                        } else {
                            Text(transaction.note.isEmpty ? "-" : editingTransaction.note)
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .onAppear {
                editingTransaction = transaction
                if transaction.title.isEmpty
                {
                    editMode?.wrappedValue = .active
                    DispatchQueue.main.async {
                        nameFieldIsFocused = true
                    }
                }
            }
            .onDisappear(){
                update()
            }
            
            
        }
    }
}
