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
            
            assignmentView
                .padding(.top, 20)
        }
        .onAppear {
            fetchAssignments(for: selectedDate)
        }
    }
    
    private var assignmentView: some View {
        VStack {
            
            if let assignment = assignment {
                ForEach(assignment.value.sorted { $0.section_name ?? "" < $1.section_name ?? "" }) { item in
                    NavigationLink(destination: IndividualAssignmentView(assignment: item)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.short_description ?? "Unnamed Assignment")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .underline()
                            Text(item.section_name ?? "")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding()
                                .background(item.missing ?? false ? Color(red: 1.0, green: 0.9, blue: 0.9) : Color.white)
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
            else if let error = error{
                HStack {
                    Image(systemName: "exclamationmark.octagon.fill")
                        .foregroundColor(.red)
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                }.padding()
                
            } else {
                ProgressView("Loading...").task {
                    fetchAssignments(for: selectedDate)
                }
            }
        }
    }
    
    private func fetchAssignments(for date: Date) {
        do {
            let formattedDate = DateFormatter().string(from: date)
            guard let userId = user?.id else {
                self.error = NSError(domain: "InvalidUserID", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid user ID"])
                return
            }
            let endpoint = "academics/\(userId)/assignments?start_date=\(date.ISO8601Format())"
            try apiManager.request(endpoint: endpoint) { result, error in
                self.assignment = result
                self.error = error
            }
        } catch {
            self.error = error
        }
    }
    
    private func formattedDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
