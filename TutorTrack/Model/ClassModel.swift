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
    
    init(){
        self.title = ""
    }
}
