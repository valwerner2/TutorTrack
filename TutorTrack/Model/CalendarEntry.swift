//
//  CalendarEntry.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import Foundation
import SwiftData

@Model
final class CalendarEntry {
    var dateInterval: DateInterval
    
    init(){
        // 3600 seconds = 1 hour
        self.dateInterval = DateInterval(start: Date(), duration: 3600)
    }
}
