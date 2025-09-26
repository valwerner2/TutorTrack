//
//  ClassViewTransactionPicker.swift
//  TutorTrack
//
//  Created by Valentin Werner on 26.09.25.
//

import SwiftUI
import SwiftData

struct ClassViewTransactionPicker: View {
    @Binding var pupil: PupilModel?
    @Binding var transaction: TransactionModel?
    
    @Query(
        sort: [SortDescriptor(\TransactionModel.date, order: .forward)]
    )
    private var allTransactions: [TransactionModel]
    
    private var filteredTransactions: [TransactionModel] {
        return allTransactions.filter {$0.pupil == pupil}
    }
    
    var body: some View {
        if pupil == nil{
            Text("Select a person to show transactions!").bold()
        }else if !filteredTransactions.isEmpty{
            ForEach(filteredTransactions) { currentTransaction in
                HStack{
                    Text(currentTransaction.title)
                    Spacer()
                    if transaction == currentTransaction
                    {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    transaction = transaction == currentTransaction ? nil : currentTransaction
                }
            }
        }else if let currentPupil = pupil{
            
            Text("No transactions for \(currentPupil.name) found")
        }
        
    }
}
