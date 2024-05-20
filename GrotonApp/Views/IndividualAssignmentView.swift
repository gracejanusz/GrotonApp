//
//  IndividualAssignmentView.swift
//  GrotonApp
//
//  Created by Grace Janusz on 5/19/24.
//

import Foundation
import SwiftUI

struct IndividualAssignmentView: View {
    @Environment(APIManager.self) private var apiManager: APIManager
    var assignment: Assignment
    
    var body: some View {
        ZStack {
            Color.darkRed
                .ignoresSafeArea()
            individualAssignmentView
                .padding(.top, 20)
        }
    }
    private var individualAssignmentView: some View{
            VStack(alignment: .leading, spacing: 8) {
                Text(assignment.short_description ?? "Unnamed Assignment")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(assignment.date_due ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
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
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
        
        private var backButton: some View {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
