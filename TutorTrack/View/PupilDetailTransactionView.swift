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
        Section(
            header:
                Text("Transactions")
                .font(.headline)
                .textCase(nil)
        ) {
            if editMode?.wrappedValue.isEditing != true && !pupil.transactions.isEmpty {
                PupilDetailTransactionViewList(transactions: Array(pupil.transactions.prefix(countToDisplay)))
                
                if pupil.transactions.count >= countToDisplay {
                    Button("show all") {
                        showSheet = true
                    }
                    .sheet(isPresented: $showSheet) {
                        NavigationStack{
                            List{
                                PupilDetailTransactionViewList(transactions: Array(pupil.transactions))
                            }
                            .navigationTitle("Transactions of " + pupil.name)
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
            else if editMode?.wrappedValue.isEditing == true
            {
                Text("Exit Editing-Mode to see transactions")
            }
            else
            {
                Text("No transations linked to " + pupil.name)
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
                HStack {
                    Text(currentTransaction.title)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(String(currentTransaction.amount) + "zł")
                        .frame(width: 80, alignment: .leading)

                    Text(currentTransaction.calendarEntry.start, format: .dateTime.day().month().year())
                        .frame(width: 120, alignment: .trailing)
                }
            }
        }
    }
}
