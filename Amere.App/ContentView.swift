//
//  ContentView.swift
//  Amere.App
//  Created by Jahaira Maxwell-Myers on 5/16/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var items = UserDefaults.standard.stringArray(forKey: "items") ?? []
    @State private var isPresentingAddActivity = false
    
    func removeRows(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: removeRows)
            }
            .navigationBarTitle("Amare")
            .navigationBarItems(trailing: Button(action: {
                isPresentingAddActivity = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $isPresentingAddActivity, content: {
                AddActivityView(isPresented: $isPresentingAddActivity, items: $items)
            })
            .preferredColorScheme(.dark) // Set the preferred color scheme to dark
        }
    }
}

struct AddActivityView: View {
    
    @Binding var isPresented: Bool
    @Binding var items: [String]
    @State private var newActivity = ""
    @State private var type = "Mind"
    
    let types = [
        "Mind": Color.blue,
        "Body": Color.green,
        "Spirit": Color.yellow
    ]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Activity...", text: $newActivity)
                
                Picker("Type", selection: $type) {
                    ForEach(types.keys.sorted(), id: \.self) { key in
                        Button(action: {
                            self.type = key
                        }) {
                            Text(key)
                                .foregroundColor(Color.blue)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        addItem()
                    }, label: {
                        Text("Done")
                    })
                    Button(action: {
                        isPresented = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    })
                }
            }
            .navigationBarTitle("New Activity")
        }
        .preferredColorScheme(.dark) // Set the preferred color scheme to dark
    }
    
    private func addItem() {
        if !newActivity.isEmpty {
            items.append(newActivity)
            UserDefaults.standard.setValue(items, forKey: "items")
        }
        isPresented = false
    }
}
