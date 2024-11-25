//
//  ContentView.swift
//  Kartenspiel
//
//  Created by Thomas Funke on 24.11.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var showingAddPlayer = false
    @State private var newPlayerName = ""
    @State private var selectedPlayer: Player?
    @State private var playerToDelete: Player?
    @State private var showingDeleteAlert = false
    
    var body: some View {
        List {
            ForEach(viewModel.players) { player in
                PlayerRow(player: player)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedPlayer = player
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            playerToDelete = player
                            showingDeleteAlert = true
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                    }
            }
        }
        .navigationTitle("Skat Spieler")
        .toolbar {
            Button {
                showingAddPlayer = true
            } label: {
                Label("Spieler hinzufügen", systemImage: "person.badge.plus")
            }
        }
        .alert("Spieler löschen", isPresented: $showingDeleteAlert) {
            Button("Abbrechen", role: .cancel) {}
            Button("Löschen", role: .destructive) {
                if let player = playerToDelete {
                    viewModel.removePlayer(player)
                }
            }
        } message: {
            if let player = playerToDelete {
                Text("Möchten Sie \(player.name) wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.")
            }
        }
        .sheet(isPresented: $showingAddPlayer) {
            NavigationStack {
                Form {
                    TextField("Spielername", text: $newPlayerName)
                }
                .navigationTitle("Neuer Spieler")
                .navigationBarItems(
                    leading: Button("Abbrechen") {
                        showingAddPlayer = false
                    },
                    trailing: Button("Hinzufügen") {
                        if !newPlayerName.isEmpty {
                            viewModel.addPlayer(name: newPlayerName)
                            newPlayerName = ""
                            showingAddPlayer = false
                        }
                    }
                )
            }
        }
        .sheet(item: $selectedPlayer) { player in
            AddGameView(viewModel: viewModel, player: player)
        }
    }
}

struct PlayerRow: View {
    let player: Player
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(player.name)
                .font(.headline)
            Text("Punkte: \(player.totalPoints)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            if !player.games.isEmpty {
                Text("Letzte Runde: \(player.games.last?.points ?? 0)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView(viewModel: GameViewModel())
    }
}
