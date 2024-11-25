import Foundation

class GameViewModel: ObservableObject {
    @Published var players: [Player] = [] {
        didSet {
            savePlayers()
        }
    }
    
    init() {
        loadPlayers()
    }
    
    func addPlayer(name: String) {
        let player = Player(name: name, games: [])
        players.append(player)
    }
    
    func addGame(to player: Player, points: Int, note: String?) {
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            let game = Game(points: points, date: Date(), note: note)
            players[index].games.append(game)
        }
    }
    
    func removePlayer(_ player: Player) {
        players.removeAll(where: { $0.id == player.id })
    }
    
    func removeAllGames() {
        for index in players.indices {
            players[index].games.removeAll()
        }
    }
    
    private func savePlayers() {
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: "Players")
        }
    }
    
    private func loadPlayers() {
        if let data = UserDefaults.standard.data(forKey: "Players"),
           let decoded = try? JSONDecoder().decode([Player].self, from: data) {
            players = decoded
        }
    }
}
