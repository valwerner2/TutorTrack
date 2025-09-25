//
//  Calendar View.swift
//  TutorTrack
//
//  Created by Valentin Werner on 04.09.25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var blockers: [BlockerModel]
    @Query private var classes: [ClassModel]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(){
                Section(
                    header:
                        Text("Classes")
                        .font(.headline)
                        .textCase(nil)
                ) {
                    ForEach(classes){ currentClass in
                        NavigationLink {
                            ClassView(classModel: currentClass)
                        } label: {
                            HStack{
                                Text(currentClass.title)
                                Spacer()
                                Text(currentClass.dateInterval.start, format: .dateTime.day().month().year())
                                    .frame(width: 120, alignment: .trailing)
                                Spacer()
                                Text(currentClass.dateInterval.end, format: .dateTime.day().month().year())
                                    .frame(width: 120, alignment: .trailing)
                            }
                        }
                    }
                    .onDelete(perform: deleteClass)
                }
                Section(
                    header:
                        Text("Blocker")
                        .font(.headline)
                        .textCase(nil)
                ) {
                    ForEach(blockers){ currentBlocker in
                        NavigationLink {
                            BlockerView(blocker: currentBlocker)
                        } label: {
                            HStack{
                                Text(currentBlocker.title)
                                Spacer()
                                Text(currentBlocker.dateInterval.start, format: .dateTime.day().month().year())
                                    .frame(width: 120, alignment: .trailing)
                                Spacer()
                                Text(currentBlocker.dateInterval.end, format: .dateTime.day().month().year())
                                    .frame(width: 120, alignment: .trailing)
                            }
                        }
                    }
                    .onDelete(perform: deleteBlocker)
                }
            }
            .navigationTitle("Calendar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Menu {
                        Button(action: addClass) {
                            Label("Class", systemImage: "calendar.and.person")
                        }
                        Button(action: addBlocker) {
                            Label("Blocker", systemImage: "calendar.badge.minus")
                        }
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(for: BlockerModel.self) { navDest in
                BlockerView(blocker: navDest)
            }
            .navigationDestination(for: ClassModel.self) { navDest in
                ClassView(classModel: navDest)
            }
        }
    }
    
    private func addClass(){
        let classModel = ClassModel()
        addItem(classModel)
    }
    
    private func addBlocker(){
        let blockerModel = BlockerModel()
        addItem(blockerModel)
    }
    
    private func addItem<T: PersistentModel>(_ item: T) {
        withAnimation {
            modelContext.insert(item)
            path.append(item)
        }
    }

    private func deleteBlocker(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(blockers[index])
            }
        }
    }
    private func deleteClass(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(classes[index])
            }
        }
    }
}
