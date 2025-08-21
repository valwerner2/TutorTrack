//
//  ContentView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 21.08.25.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            Text("Today")
                .tabItem{
                    Label("Calendar", systemImage: "calendar")
                }
            Text("money")
                .tabItem{
                    Label("Payments", systemImage: "polishzlotysign.circle")
                }
            PupilView()
                .tabItem{
                    Label("People", systemImage: "person.3.sequence.fill")
                }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Pupil.self, inMemory: true)
}
