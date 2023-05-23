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
        UserDefaults.standard.setValue(items, forKey: "items")
    }
    
    func activityDescription(_ activity: String, _ category: String, _ days: Set<String>, _ duration: Int) -> String {
        var description = "Activity: \(activity)\nCategory: \(category)\nDays: "
        let daysString = days.sorted().joined(separator: ", ")
        description += "\(daysString)\nDuration: \(duration) minutes"
        return description
    }
    
    func categoryColor(_ category: String) -> Color {
        let categories = [
            "Mind": Color.blue,
            "Body": Color.green,
            "Spirit": Color.yellow
        ]
        return categories[category] ?? .gray
    }
    
    var body: some View {
        RingsView()
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    let components = activityDescription(item, "Category", Set<String>(), 0).components(separatedBy: "\n")
                    let activity = components[0]
                    let category = components[1]
                    let days = components[2]
                    let duration = components[3]
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(activity)
                            .font(.headline)
                        Text(days)
                            .font(.subheadline)
                        Text(duration)
                            .font(.subheadline)
                    }
                    .padding()
                    .background(categoryColor(category))
                    .cornerRadius(8)
                    .foregroundColor(.white)
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
            .preferredColorScheme(.dark)
        }
    }
}

struct AddActivityView: View {
    @Binding var isPresented: Bool
    @Binding var items: [String]
    @State private var newActivity = ""
    @State private var selectedCategory: String?
    @State private var selectedDays: Set<String> = []
    @State private var duration = 0
    
    let categories = [
        "Mind": (Color.blue, "Mind"),
        "Body": (Color.green, "Body"),
        "Spirit": (Color.yellow, "Spirit")
    ]
    
    let daysOfWeek = [
        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Activity")) {
                    TextField("Enter Activity...", text: $newActivity)
                }
                
                Section(header: Text("Category")) {
                    HStack {
                        ForEach(categories.keys.sorted(), id: \.self) { key in
                            Button(action: {
                                selectedCategory = key
                            }) {
                                VStack {
                                    Circle()
                                        .fill(categories[key]!.0)
                                        .frame(width: 100, height: 80)
                                        .overlay(
                                            Circle()
                                                .stroke(selectedCategory == key ? categories[key]!.0 : Color.clear, lineWidth: 4)
                                                .glowEffect(selectedCategory == key ? Color.white : Color.clear, radius: 8)
                                        )
                                    
                                    Text(categories[key]!.1)
                                        .foregroundColor(.primary)
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                
                Section(header: Text("Days of the Week")) {
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(daysOfWeek, id: \.self) { day in
                                Button(action: {
                                    if selectedDays.contains(day) {
                                        selectedDays.remove(day)
                                    } else {
                                        selectedDays.insert(day)
                                    }
                                }) {
                                    Text(day)
                                        .foregroundColor(selectedDays.contains(day) ? .white : .primary)
                                        .padding()
                                        .background(selectedDays.contains(day) ? Color.blue : Color.secondary)
                                        .clipShape(Circle())
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Section(header: Text("Duration (minutes)")) {
                    Stepper(value: $duration, in: 0...120, step: 15) {
                        Text("\(duration) minutes")
                    }
                }
                
                Section {
                    Button(action: {
                        addItem()
                    }, label: {
                        Text("Save")
                    })
                    Button(action: {
                        isPresented = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    })
                }
            }
            .navigationBarTitle("Add Activity")
            .preferredColorScheme(.dark)
        }
    }
    
    private func addItem() {
        if !newActivity.isEmpty, let category = selectedCategory {
            items.append(newActivity)
            UserDefaults.standard.setValue(items, forKey: "items")
        }
        isPresented = false
    }
}

struct GlowEffect: ViewModifier {
    var color: Color
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius)
            .overlay(content.blur(radius: radius))
    }
}

extension View {
    func glowEffect(_ color: Color, radius: CGFloat) -> some View {
        self.modifier(GlowEffect(color: color, radius: radius))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


