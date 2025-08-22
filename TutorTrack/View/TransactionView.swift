//
//  TransactionView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import SwiftUI

struct TransactionView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header:
                        Text("Summary")
                        .font(.headline)
                        .textCase(nil)
                ) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("187")
                        }
                        HStack {
                            Text("Month")
                            Spacer()
                            Text("187")
                        }
                        HStack {
                            Text("Year")
                            Spacer()
                            Text("187")
                        }
                        HStack {
                            Text("Pending")
                            Spacer()
                            Text("187")
                        }
                    }
                    .padding(.vertical, 8)
                }
                Section(
                    header:
                        Text("Pending")
                        .font(.headline)
                        .textCase(nil)
                ) {
                    
                }
                
                Section(
                    header:
                        Text("History")
                        .font(.headline)
                        .textCase(nil)
                ) {
                    
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addTransaction) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    private func addTransaction() {
        withAnimation {
            /*
            let newPupil = Pupil()
            modelContext.insert(newPupil)
            path.append(newPupil)
             */
        }
    }

    private func deleteTransaction(offsets: IndexSet) {
        withAnimation {
            /*
            for index in offsets {
                modelContext.delete(pupils[index])
            }
             */
        }
    }
}
