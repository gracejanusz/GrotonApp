//
//  Schedule.swift
//  GrotonApp
//
//  Created by Grace Janusz on 4/8/24.
//

import Foundation

struct Schedule: Codable, Identifiable {
    let id = UUID()
    var section_id: Int32?
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
    var faculty_user_id: Int32?
    var attendance_required: Bool?
    var offering_type: OfferingType
}
