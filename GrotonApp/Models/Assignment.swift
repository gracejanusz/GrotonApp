////
////  Assignment.swift
////  GrotonApp
////
////  Created by Grace Janusz on 5/2/24.
////
//
import Foundation

struct Assignment: Codable, Identifiable {
    let id = UUID()
        var section_name: String?
        var section_id: Int?
        var assignment_id: Int?
        var short_description: String?
        var date_assigned: String?
        var date_due: String?
        var long_description: String?
        var assignment_type: String?
        var grade_book: Bool?
        var online_submission: Bool?
        var assignment_status: Int?
        var assessment: Bool?
        var assessment_locked: Bool?
        var major: Int?
        var discussion: Bool?
        var formative: Bool?
        var exempt: Bool?
        var incomplete: Bool?
        var late: Bool?
        var missing: Bool?
        var rubric: Bool?
        var user_task: Bool?
    }
    

        

