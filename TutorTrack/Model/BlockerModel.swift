//
//  BlockerModel.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import Foundation
import SwiftData

@Model
final class BlockerModel {
    var title: String
    var dateInterval: DateInterval
    var note: String
    
    init(){
        self.title = ""
        self.dateInterval = DateInterval()
        self.note = ""
    }
}
