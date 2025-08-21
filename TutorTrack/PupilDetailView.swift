//
//  PupilDetailView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 21.08.25.
//

import SwiftUI

struct PupilDetailView: View {
    let pupil: Pupil
    
    var body: some View {
        Text("Name: \(pupil.name)")
        Text("Email: \(pupil.email)")
        Text("Phone: \(pupil.phone)")
        Text("Email-Parent: \(pupil.phoneParent)")
        Text("Hourly-Rate: \(pupil.hourlyRate)")
    }
}
