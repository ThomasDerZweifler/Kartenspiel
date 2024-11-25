import Foundation

struct Player: Identifiable, Codable {
    var id = UUID()
    var name: String
    var games: [Game]
    
    var totalPoints: Int {
        games.reduce(0) { $0 + $1.points }
    }
}

struct Game: Identifiable, Codable {
    var id = UUID()
    var points: Int
    var date: Date
    var note: String?
}
