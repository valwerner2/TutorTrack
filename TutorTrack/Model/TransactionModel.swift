//
//  TransactionModel.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import Foundation
import SwiftData

@Model
final class TransactionModel {
    var amount: Double
    var isBankTransfer: Bool?
    var pupil: PupilModel?
    var date: Date
    var title: String
    var note: String
    
    init() {
        self.amount = 0
        self.isBankTransfer = true
        self.pupil = nil
        self.date = Date()
        self.title = ""
        self.note = ""
    }
}
