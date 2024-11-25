import SwiftUI

struct SettingsView: View {
    @AppStorage("colorScheme") private var colorScheme: Int = 0  // 0 = System, 1 = Hell, 2 = Dunkel
    
    var body: some View {
        Form {
            Section(header: Text("Erscheinungsbild")) {
                Picker("Erscheinungsbild", selection: $colorScheme) {
                    Text("System").tag(0)
                    Text("Hell").tag(1)
                    Text("Dunkel").tag(2)
                }
            }
            
            Section(header: Text("Info")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Einstellungen")
        .preferredColorScheme(colorScheme == 0 ? .none : colorScheme == 1 ? .light : .dark)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
