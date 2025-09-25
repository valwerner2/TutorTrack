//
//  ClassModel.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.09.25.
//

import Foundation
import SwiftData

@Model
final class ClassModel {
    var title: String
    var pupilModel: PupilModel?
    var transaction: TransactionModel?
    var dateInterval: DateInterval
    var note: String
    
    init(){
        self.title = ""
        
        let now = Date()
        let oneHourLater = Calendar.current.date(byAdding: .hour, value: 1, to: now)!
        self.dateInterval = DateInterval(start: now, end: oneHourLater)
        
        self.note = ""
    }
}
