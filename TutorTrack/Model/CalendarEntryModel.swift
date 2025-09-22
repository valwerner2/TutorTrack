//
//  CalendarEntry.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import Foundation
import SwiftData

@Model
final class CalendarEntryModel {
    var start: Date
    var end: Date?
    
    init(){
        self.start = Date()
    }
    init(endDate: Date){
        self.start = Date()
        self.end = endDate
    
    }
}
