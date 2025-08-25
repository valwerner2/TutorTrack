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
    
    
    
    private var transactions: [TransactionModel] = []
    

    
    func update(from transactions: [TransactionModel]) {
        let now = Date()
        
        let todayTransactions = transactions.filter({Calendar.current.isDate($0.calendarEntry.start, inSameDayAs: now)})
        
        let monthTransactions = transactions.filter {
            Calendar.current.isDate($0.calendarEntry.start, equalTo: now, toGranularity: .month)
        }
        
        let yearTransactions = transactions.filter {
            Calendar.current.isDate($0.calendarEntry.start, equalTo: now, toGranularity: .year)
        }
        
        self.amountToday = sumTransactions(array: todayTransactions)
        
        self.amountMonth = sumTransactions(array: monthTransactions)
        
        self.amountYear = sumTransactions(array: yearTransactions)
        
        self.amountTotal = sumTransactions(array: transactions)
    }
    
    func sumTransactions(array: [TransactionModel]) -> Double {
        var sum: Double = 0
        array.forEach { current in
            if current.isBankTransfer == nil {
                sum += abs(current.amount)
            }
        }
        return sum
    }
}
