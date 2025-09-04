//
//  PupilDetailTransactionView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 04.09.25.
//

import SwiftUI

struct PupilDetailTransactionView: View {
    let pupil: PupilModel
    
    let countToDisplay = 3
    
    @Environment(\.editMode) private var editMode
    @FocusState private var nameFieldIsFocused: Bool
    
    @State private var showSheet = false
    
    var body: some View {
        if editMode?.wrappedValue.isEditing != true && !pupil.transactions.isEmpty {
            Section(
                header:
                    Text("Transactions")
                    .font(.headline)
                    .textCase(nil)
            ) {
                PupilDetailTransactionViewList(transactions: Array(pupil.transactions.prefix(countToDisplay)))
                
                if pupil.transactions.count >= countToDisplay {
                    Button("show all") {
                        showSheet = true
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                NavigationStack{
                    List{
                        PupilDetailTransactionViewList(transactions: Array(pupil.transactions))
                    }
                    .navigationTitle(pupil.name + "'s Transactions")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                showSheet = false
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PupilDetailTransactionViewList: View{
    let transactions: [TransactionModel]
    
    var body: some View {
        ForEach(transactions) { currentTransaction in
            NavigationLink {
                TransactionDetailView(transaction: currentTransaction, update: nil)
            } label: {
                HStack{
                    Text(currentTransaction.title)
                    Spacer()
                    Text(String(currentTransaction.amount))
                    Spacer()
                    Text("DATE")
                }
            }
        }
        }
}
