//
//  Item.swift
//  TutorTrack
//
//  Created by Valentin Werner on 21.08.25.
//

import Foundation
import SwiftData

@Model
final class Pupil {
    var name: String
    var email: String
    var phone: String
    var phoneParent: String
    var hourlyRate: Double
    
    init()
    {
        self.name = ""
        self.email = ""
        self.phone = ""
        self.phoneParent = ""
        self.hourlyRate = 0
    }
    
    init(name: String, email: String, phone: String, phoneParent: String, hourlyRate: Double)
    {
        self.name = name
        self.email = email
        self.phone = phone
        self.phoneParent = phoneParent
        self.hourlyRate = hourlyRate
    }
}
