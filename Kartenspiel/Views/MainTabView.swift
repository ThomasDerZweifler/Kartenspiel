import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        TabView {
            NavigationStack {
                ContentView(viewModel: viewModel)
            }
            .tabItem {
                Label("Spieler", systemImage: "person.3")
            }
            
            NavigationStack {
                GameOverviewView(viewModel: viewModel)
            }
            .tabItem {
                Label("Übersicht", systemImage: "list.bullet.clipboard")
            }
            
            NavigationStack {
                GameTypesView()
            }
            .tabItem {
                Label("Spielwerte", systemImage: "chart.bar")
            }
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Einstellungen", systemImage: "gear")
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
