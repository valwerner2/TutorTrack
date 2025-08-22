//
//  Transaction.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import Foundation
import SwiftData

@Model
final class Transaction {
    var amount: Double
    var isBankTransfer: Bool?
    var pupil: Pupil
    var calendarEntry: CalendarEntry?
    var title: String
    var note: String
    
    init() {
        self.amount = 0
        self.isBankTransfer = true
        self.pupil = Pupil()
        self.title = ""
        self.note = ""
    }
}
