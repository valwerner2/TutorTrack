//
//  TransactionViewModel.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import SwiftData
import Combine
import Foundation

@MainActor
class TransactionViewModel: ObservableObject {
    
    @Published var amountToday: Double = 0
    @Published var amountMonth: Double = 0
    @Published var amountYear: Double = 0
    @Published var amountTotal: Double = 0
    @Published var amountPending: Double = 0
    
    
    
    private var transactions: [Transaction] = []
    

    
    func update(from transactions: [Transaction]) {
        let now = Date()
        
        var todayTransactions = transactions.filter({Calendar.current.isDate($0.calendarEntry.start, inSameDayAs: now)})
        
        self.amountToday = 0
        
        todayTransactions.forEach { current in
            if current.isBankTransfer != nil {
                self.amountToday += abs(current.amount)
            }
        }
    }
}
