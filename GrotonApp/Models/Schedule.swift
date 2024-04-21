//
//  Schedule.swift
//  GrotonApp
//
//  Created by Grace Janusz on 4/8/24.
//

import Foundation

struct Schedule: Codable, Identifiable {
    private static var nextId = 0;
    var id: Int
    
    init(section_id: String? = nil, section_identifier: String? = nil, course_title: String? = nil, course_code: String? = nil, section_name: String? = nil, block_id: Int? = nil, block_name: String? = nil, room_id: Int? = nil, room_name: String? = nil, room_number: String? = nil, room_capacity: Int? = nil, room_code: String? = nil, faculty_name: String? = nil, faculty_firstname: String? = nil, faculty_lastname: String? = nil, start_time: String? = nil, end_time: String? = nil, meeting_date: String? = nil, faculty_user_id: String? = nil, attendance_required: Bool? = nil) {
        
        // set an arbitrary ID for each schedule item (since none is given by Blackbaud)
        self.id = Schedule.nextId
        Schedule.nextId += 1
        
        self.section_id = section_id
        self.section_identifier = section_identifier
        self.course_title = course_title
        self.course_code = course_code
        self.section_name = section_name
        self.block_id = block_id
        self.block_name = block_name
        self.room_id = room_id
        self.room_name = room_name
        self.room_number = room_number
        self.room_capacity = room_capacity
        self.room_code = room_code
        self.faculty_name = faculty_name
        self.faculty_firstname = faculty_firstname
        self.faculty_lastname = faculty_lastname
        self.start_time = start_time
        self.end_time = end_time
        self.meeting_date = meeting_date
        self.faculty_user_id = faculty_user_id
        self.attendance_required = attendance_required
    }
    
    var section_id: String?
    var section_identifier: String?
    var course_title: String?
    var course_code: String?
    var section_name: String?
    var block_id: Int?
    var block_name: String?
    var room_id: Int?
    var room_name: String?
    var room_number: String?
    var room_capacity: Int?
    var room_code: String?
    var faculty_name: String?
    var faculty_firstname: String?
    var faculty_lastname: String?
    var start_time: String?
    var end_time: String?
    var meeting_date: String?
    var faculty_user_id: String?
    var attendance_required: Bool?
    
    //            "offering_type": {
    //                "$ref": "#/components/schemas/OfferingType"
    //            }
    
    
    
}
