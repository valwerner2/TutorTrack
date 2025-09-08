//
//  MainView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 21.08.25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarView()
                .tabItem{
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0)
            TransactionView()
                .tabItem{
                    Label("Transactions", systemImage: "polishzlotysign.circle")
                }
                .tag(1)
            PupilView()
                .tabItem{
                    Label("People", systemImage: "person.3.sequence.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: PupilModel.self, inMemory: true)
}
