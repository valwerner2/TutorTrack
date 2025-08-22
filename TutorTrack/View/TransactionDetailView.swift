//
//  TransactionDetailView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//


import SwiftUI

struct TransactionDetailView: View {
    let transaction: TransactionModel
    
    @State private var editingTransaction = TransactionModel()
    @Environment(\.editMode) private var editMode
    @FocusState private var nameFieldIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(transaction.title)
                .font(.largeTitle)
            
            List {
                if editMode?.wrappedValue.isEditing == true {
                    HStack {
                        Text("Name").bold()
                        Spacer()
                        TextField("Name", text: $editingTransaction.title)
                            .focused($nameFieldIsFocused)
                    }
                }
                
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
                    Text("Note").bold()
                    Spacer()
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Note", text: $editingTransaction.note)
                    } else {
                        Text(transaction.note.isEmpty ? "-" : editingTransaction.note)
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
            
        }
    }
}
