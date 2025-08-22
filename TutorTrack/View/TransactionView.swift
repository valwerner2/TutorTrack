//
//  TransactionView.swift
//  TutorTrack
//
//  Created by Valentin Werner on 22.08.25.
//

import SwiftUI
import SwiftData

struct TransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [TransactionModel]

    @StateObject private var viewModel = TransactionViewModel()
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                            Text(String(viewModel.amountToday))
                        }
                        HStack {
                            Text("Month")
                            Spacer()
                            Text(String(viewModel.amountMonth))
                        }
                        HStack {
                            Text("Year")
                            Spacer()
                            Text(String(viewModel.amountYear))
                        }
                        HStack {
                            Text("Total")
                            Spacer()
                            Text(String(viewModel.amountTotal))
                        }
                        HStack {
                            Text("Pending")
                            Spacer()
                            Text(String(viewModel.amountPending))
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
            .navigationDestination(for: TransactionModel.self) { transaction in
                TransactionDetailView(transaction: transaction)
            }
        }
        .onChange(of: transactions, initial: true ) { _, newValue in
            viewModel.update(from: newValue)
        }
        .onAppear {
            viewModel.update(from: transactions)
        }
    }
    private func addTransaction() {
        withAnimation {
            let newTransaction = TransactionModel()
            modelContext.insert(newTransaction)
            path.append(newTransaction)
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
