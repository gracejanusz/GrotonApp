////
////  AssignmentCollection.swift
////  GrotonApp
////
////  Created by Grace Janusz on 5/2/24.
////
//
import Foundation

struct AssignmentCollection: Codable, Hashable{
    var count: Int32?
    var next_link: String?
    var value: [Assignment]
}
