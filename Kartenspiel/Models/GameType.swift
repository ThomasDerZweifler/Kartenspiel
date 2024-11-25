import Foundation

struct GameType: Identifiable {
    let id = UUID()
    let name: String
    let baseValue: Int
    let description: String
    let multiplierOptions: [Int]
}

struct GameTypes {
    static let allTypes = [
        GameType(
            name: "Grand",
            baseValue: 24,
            description: "Alle vier Buben sind Trumpf",
            multiplierOptions: [1, 2, 3, 4]
        ),
        GameType(
            name: "Null",
            baseValue: 23,
            description: "Kein Stich darf gemacht werden",
            multiplierOptions: [1]
        ),
        GameType(
            name: "Null Hand",
            baseValue: 35,
            description: "Kein Stich, ohne Skat",
            multiplierOptions: [1]
        ),
        GameType(
            name: "Null Ouvert",
            baseValue: 46,
            description: "Kein Stich, mit offenen Karten",
            multiplierOptions: [1]
        ),
        GameType(
            name: "Null Ouvert Hand",
            baseValue: 59,
            description: "Kein Stich, ohne Skat, mit offenen Karten",
            multiplierOptions: [1]
        ),
        GameType(
            name: "♣ Kreuz",
            baseValue: 12,
            description: "Kreuz ist Trumpf",
            multiplierOptions: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        ),
        GameType(
            name: "♠ Pik",
            baseValue: 11,
            description: "Pik ist Trumpf",
            multiplierOptions: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        ),
        GameType(
            name: "♥ Herz",
            baseValue: 10,
            description: "Herz ist Trumpf",
            multiplierOptions: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        ),
        GameType(
            name: "♦ Karo",
            baseValue: 9,
            description: "Karo ist Trumpf",
            multiplierOptions: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        )
    ]
}
