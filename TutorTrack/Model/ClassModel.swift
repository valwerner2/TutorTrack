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
        
        self.dateInterval = DateInterval(start: Date(), duration: 3600)
        
        self.note = ""
    }
}
