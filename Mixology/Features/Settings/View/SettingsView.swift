import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $viewModel.enableNotifications)
                }
                
                Section(header: Text("Date and Time")) {
                    DatePicker("Select Time", selection: $viewModel.selectedDateTime, displayedComponents: [.hourAndMinute])
                        .disabled(!viewModel.enableNotifications)
                    
                    Section {
                        Button(action: {
                            showAlert = true
                            viewModel.saveSettings()
                        }) {
                            Text("Save Settings")
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Settings Saved"), message: Text("Your settings have been saved."), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
