import SwiftUI

struct GameOverviewView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var showingDeleteConfirmation = false
    @State private var selectedPlayer: Player?
    
    var allGames: [(Player, Game)] {
        viewModel.players.flatMap { player in
            player.games.map { (player, $0) }
        }.sorted { $0.1.date > $1.1.date }
    }
    
    var body: some View {
        List {
            Section(header: Text("Aktuelle Runde")) {
                ForEach(viewModel.players) { player in
                    HStack {
                        Text(player.name)
                            .foregroundColor(selectedPlayer?.id == player.id ? .accentColor : .primary)
                        Spacer()
                        Text("\(player.totalPoints)")
                            .bold()
                            .foregroundColor(selectedPlayer?.id == player.id ? .accentColor : .primary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            if selectedPlayer?.id == player.id {
                                selectedPlayer = nil
                            } else {
                                selectedPlayer = player
                            }
                        }
                    }
                }
            }
            
            if !allGames.isEmpty {
                Section(header: Text("Gespielte Spiele")) {
                    ForEach(allGames, id: \.1.id) { player, game in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(player.name)
                                    .font(.headline)
                                    .foregroundColor(selectedPlayer?.id == player.id ? .accentColor : .primary)
                                Spacer()
                                Text("\(game.points)")
                                    .bold()
                                    .foregroundColor(selectedPlayer?.id == player.id ? .accentColor : .primary)
                            }
                            if let note = game.note {
                                Text(note)
                                    .font(.subheadline)
                                    .foregroundColor(selectedPlayer?.id == player.id ? .accentColor : .secondary)
                            }
                            Text(game.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundColor(selectedPlayer?.id == player.id ? .accentColor.opacity(0.8) : .secondary)
                        }
                        .listRowBackground(selectedPlayer?.id == player.id ? Color.accentColor.opacity(0.1) : Color.clear)
                    }
                    
                    Button(role: .destructive) {
                        showingDeleteConfirmation = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Alle Spiele löschen")
                        }
                    }
                }
            }
        }
        .navigationTitle("Spielübersicht")
        .alert("Alle Spiele löschen?", isPresented: $showingDeleteConfirmation) {
            Button("Abbrechen", role: .cancel) { }
            Button("Löschen", role: .destructive) {
                withAnimation {
                    viewModel.removeAllGames()
                }
            }
        } message: {
            Text("Diese Aktion kann nicht rückgängig gemacht werden. Alle Spielstände werden zurückgesetzt.")
        }
    }
}

struct GameOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameOverviewView(viewModel: GameViewModel())
        }
    }
}
