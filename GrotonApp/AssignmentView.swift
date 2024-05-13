////
////  AssignmentView.swift
////  GrotonApp
////
////  Created by Grace Janusz on 5/2/24.
////
import Foundation
import SwiftUI

struct AssignmentView: View {
    @Environment(APIManager.self) private var apiManager: APIManager
    var user: User?
    @State private var assignment: AssignmentCollection?
    @State private var error: Error?
    @State private var selectedDate = Date()

    var body: some View {
        ZStack {
            Color.darkRed
                .ignoresSafeArea()
            
            assignmentview
                .padding(.top, 20)
        }
        .onAppear {
            fetchAssignments(for: selectedDate)
        }
    }
    
    private var assignmentview: some View {
        VStack {
            HStack {
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                    fetchAssignments(for: selectedDate)
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                let weekday = formattedDate(selectedDate, format: "EEEE")
                let abbreviatedDate = formattedDate(selectedDate, format: "MMM d")
                
                Text("\(weekday) \(abbreviatedDate)")
                    .bold()
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                
                Spacer()
                
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                    fetchAssignments(for: selectedDate)
                }) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
            
            if let assignment = assignment {
                // Display assignments
                ForEach(assignment.value) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.short_description ?? "Unnamed Assignment")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.vertical, 4)
                }

            } else if let error = error {
                // Display error
                HStack {
                    Image(systemName: "exclamationmark.octagon.fill")
                        .foregroundColor(.red)
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                }
                .padding()
            } else {
                ProgressView("Loading...")
                fetchAssignments(for: selectedDate)
            }
        }
        .padding()
    }

    private func fetchAssignments(for date: Date) {
        do {
            let formattedDate = DateFormatter().string(from: date)
            guard let userId = user?.id else {
                self.error = NSError(domain: "InvalidUserID", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid user ID"])
                return
            }
            let endpoint = "academics/\(userId)/assignments?start_date=\(formattedDate)"
            try apiManager.request(endpoint: endpoint) { result, error in
                self.assignment = result
                self.error = error
            }
        } catch {
            self.error = error
        }
    }

    // Function to format date
    private func formattedDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
