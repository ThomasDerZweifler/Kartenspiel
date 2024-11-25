import SwiftUI

struct AddGameView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: GameViewModel
    let player: Player
    
    @State private var points = 0
    @State private var pointsString = ""
    @State private var note = ""
    @State private var showAlert = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var newTotal: Int {
        player.totalPoints + points
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Bisheriger Stand")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(player.totalPoints)")
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.secondary)
                        VStack(alignment: .center) {
                            Text("Neue Punkte")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(points)")
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "equal")
                            .foregroundColor(.secondary)
                        VStack(alignment: .trailing) {
                            Text("Neuer Stand")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(newTotal)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                
                Section(header: Text("Punkteingabe")) {
                    Stepper("Punkte: \(points > 0 ? "+" : "")\(points)", value: $points)
                    TextField("Punkte (+/-)", text: $pointsString)
                        .keyboardType(.numbersAndPunctuation)
                        .onChange(of: pointsString) { _, newValue in
                            if let newPoints = Int(newValue) {
                                points = newPoints
                            }
                        }
                }
                
                Section(header: Text("Notiz")) {
                    TextField("Optionale Notiz", text: $note, axis: .vertical)
                        .lineLimit(1...4)
                }
                
                if !player.games.isEmpty {
                    Section(header: Text("Bisherige Spiele")) {
                        ForEach(player.games.reversed().prefix(5)) { game in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(game.points > 0 ? "+\(game.points)" : "\(game.points)")
                                        .font(.headline)
                                    if let note = game.note, !note.isEmpty {
                                        Text(note)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                Spacer()
                                Text(dateFormatter.string(from: game.date))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        if player.games.count > 5 {
                            NavigationLink("Alle Spiele anzeigen") {
                                List {
                                    ForEach(player.games.reversed()) { game in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(game.points > 0 ? "+\(game.points)" : "\(game.points)")
                                                    .font(.headline)
                                                if let note = game.note, !note.isEmpty {
                                                    Text(note)
                                                        .font(.caption)
                                                        .foregroundColor(.secondary)
                                                }
                                            }
                                            Spacer()
                                            Text(dateFormatter.string(from: game.date))
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                .navigationTitle("Alle Spiele")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Neues Spiel")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        if validateInput() {
                            viewModel.addGame(to: player, points: points, note: note.isEmpty ? nil : note)
                            dismiss()
                        } else {
                            showAlert = true
                        }
                    }
                }
            }
            .alert("Ungültige Eingabe", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Bitte geben Sie eine gültige Punktzahl ein.")
            }
            .onAppear {
                pointsString = String(points)
            }
        }
    }
    
    private func validateInput() -> Bool {
        if !pointsString.isEmpty {
            if let inputPoints = Int(pointsString) {
                points = inputPoints
                return true
            }
            return false
        }
        return true
    }
}

#Preview {
    AddGameView(
        viewModel: GameViewModel(),
        player: Player(name: "Test", games: [])
    )
}
