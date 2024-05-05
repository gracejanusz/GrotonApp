////
////  Assignment.swift
////  GrotonApp
////
////  Created by Grace Janusz on 5/2/24.
////
//
//import Foundation
//
//struct Assignment: Codable, Identifiable {
//    private static var nextId = 0;
//    var id: Int
//    
//    init(section_name: String? = nil, section_id: Int? = nil, assignment_id: Int? = nil,
//         short_description: Strin/Users/gjanusz24/Documents/GitHub/GrotonApp/GrotonApp/UserView.swiftg? = nil, date_assigned: String? = nil, date_due: String? = nil, long_description: String? = nil, assignment_type: String? = nil, grade_book: Bool? = nil, online_submission: Bool? = nil, assignment_status: Int? = nil, assessment: Bool? = nil, assessment_locked: Bool? = nil, major: Int? = nil, discussion: Bool? = nil, formative: Bool? = nil,exempt: Bool? = nil, incomplete: Bool? = nil, late: Bool? = nil, missing: Bool? = nil, rubric: Bool? = nil, user_task: Bool? = nil){
//        
//        self.section_name = section_name
//        self.section_id = section_id
//        self.assignment_id = assignment_id
//        self.short_description = short_description
//        self.date_assigned = date_assigned
//        self.date_due = date_due
//        self.long_description = long_description
//        self.assignment_type = assignment_type
//        self.grade_book = grade_book
//        self.online_submission = online_submission
//        self.assignment_status = assignment_status
//        self.assessment = assessment
//        self.assessment_locked = assessment_locked
//        self.major = major
//        self.discussion = discussion
//        self.formative = formative
//        self.exempt = exempt
//        self.incomplete = incomplete
//        self.late = late
//        self.missing = missing
//        self.rubric = rubric
//        self.user_task = user_task
//    }
//    
//    var section_name: String?
//    var section_id: Int?
//    var assignment_id: Int?
//    var short_description: String?
//    var date_assigned: String?
//    var date_due: String?
//    var long_description: String?
//    var assignment_type: String?
//    var grade_book: Bool?
//    var online_submission: Bool?
//    var assignment_status: Int?
//    var assessment: Bool?
//    var assessment_locked: Bool?
//    var major: Int?
//    var discussion: Bool?
//    var formative: Bool?
//    var exempt: Bool?
//    var incomplete: Bool?
//    var late: Bool?
//    var missing: Bool?
//    var rubric: Bool?
//    var user_task: Bool?
//    
//    
//}
