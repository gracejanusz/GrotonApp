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
    var user: User
    @State private var assignment: AssignmentCollection?
    @State private var error: Error?
    @State private var selectedDate = Date()

    var body: some View {
        ZStack {
            Color.darkRed
                .ignoresSafeArea()
            
            VStack {
                headerView
                if let assignment = assignment {
                    assignmentsList(assignment: assignment)
                } else if let error = error {
                    errorView(error: error)
                } else {
                    ProgressView("Loading...")
                        .onAppear {
                            fetchAssignments(for: selectedDate)
                        }
                }
            }
            .padding(.top, 20)
        }
    }
    
    private var headerView: some View {
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
        .padding(.horizontal)
    }
    
    private func assignmentsList(assignment: AssignmentCollection) -> some View {
        List {
            ForEach(assignment.value.sorted { $0.section_name ?? "" < $1.section_name ?? "" }, id: \.self) { item in
                NavigationLink(destination: IndividualAssignmentView(assignment: item, user: user, selectedDate: selectedDate)) {
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
        .listStyle(PlainListStyle())
    }
    
    private func errorView(error: Error) -> some View {
        HStack {
            Image(systemName: "exclamationmark.octagon.fill")
                .foregroundColor(.red)
            Text(error.localizedDescription)
                .foregroundColor(.red)
        }
    }

    private func fetchAssignments(for date: Date) {
        do {
            guard let userId = user.id else {
                self.error = NSError(domain: "InvalidUserID", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid user ID"])
                return
            }
            let endpoint = "academics/\(userId)/assignments?start_date=\(date.ISO8601Format())"
            try apiManager.request(endpoint: endpoint) { result, error in
                DispatchQueue.main.async {
                    self.assignment = result
                    self.error = error
                }
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


