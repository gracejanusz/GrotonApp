//
//  IndividualAssignmentView.swift
//  GrotonApp
//
//  Created by Grace Janusz on 5/19/24.
//

import Foundation
import SwiftUI

struct IndividualAssignmentView: View {
    var assignment: Assignment
    var user: User?
    var selectedDate: Date
    
    var body: some View {
        ZStack {
            Color.darkRed
                .ignoresSafeArea()
            List {
                Text(assignment.short_description ?? "Unnamed Assignment")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                let weekday = formattedDate(selectedDate, format: "EEEE")
                let abbreviatedDate = formattedDate(selectedDate, format: "MMM d")
                
                Text("\(weekday) \(abbreviatedDate)")
                    .bold()
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                
                Text(assignment.section_name ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(assignment.long_description ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .padding(.vertical, 4)
        }
    }
    
    
    private func formattedDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}
