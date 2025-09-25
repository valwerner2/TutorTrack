//
//  DateIntervalPicker.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.09.25.
//

import SwiftUI

struct DateIntervalPicker: View {
    @Binding var interval: DateInterval
    let allDayOption: Bool
        
    init(interval: Binding<DateInterval>, allDayOption: Bool = false) {
        self._interval = interval
        self.allDayOption = allDayOption
    }
    
    @Environment(\.editMode) private var editMode
    
    @State var allDay = false
    
    var body: some View {
        VStack{
            if editMode?.wrappedValue.isEditing == true {
                if allDayOption {
                    Toggle(
                        "All day",
                        systemImage: "calendar.badge.exclamationmark",
                        isOn: $allDay
                    )
                }
                
                DatePicker(
                    allDay ? "Date" : "Start",
                    selection: $interval.start,
                    displayedComponents: allDay ? [.date] : [.date, .hourAndMinute]
                )
                .datePickerStyle(.compact)
                if !allDay {
                    DatePicker(
                        "End",
                        selection: $interval.end,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                }
            }else{
                DateDisplayView(value: .interval(interval))
            }
        }
        .onChange(of: allDay, {
            if allDay {
                let calendar = Calendar.current
                
                // Normalize start to 00:00
                let startOfDay = calendar.startOfDay(for: interval.start)
                
                // End of day = 23:59
                var components = DateComponents()
                components.day = 1
                components.second = -60 // go back 1 minute
                
                let endOfDay = calendar.date(byAdding: components, to: startOfDay)!
                
                interval = DateInterval(start: startOfDay, end: endOfDay)
            }
        })
    }
}
