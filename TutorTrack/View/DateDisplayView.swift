//
//  DateDisplayView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 25.09.25.
//

import SwiftUI

enum DateOrInterval {
    case single(Date)
    case interval(DateInterval)
}

struct DateDisplayView: View {
    let value: DateOrInterval
    
    private var displayText: String {
        switch value {
        case .single(let date):
            return "\(date.formatted())"
        case .interval(let interval):
            
            let calendar = Calendar.current
            let componentsStart = calendar.dateComponents([.hour, .minute], from: interval.start)
            let componentsEnd = calendar.dateComponents([.hour, .minute], from: interval.end)
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy" // For the date part

            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm" // For the time part

            let startDay = dateFormatter.string(from: interval.start)
            
            if componentsStart.hour == 0 && componentsStart.minute == 0 && componentsEnd.hour == 23 && componentsEnd.minute == 59{
                return "\(startDay)"
            }
            
            let startTime = timeFormatter.string(from: interval.start)
            let endTime = timeFormatter.string(from: interval.end)
            
            
            return "\(startDay) \(startTime) – \(endTime)"
        }
    }
    
    var body: some View {
        Text(displayText)
    }
}
