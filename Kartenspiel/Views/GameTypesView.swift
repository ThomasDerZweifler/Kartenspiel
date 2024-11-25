import SwiftUI

struct GameTypesView: View {
    @State private var selectedGameType: GameType?
    @State private var selectedMultiplier = 1
    
    var calculatedPoints: Int {
        guard let gameType = selectedGameType else { return 0 }
        return gameType.baseValue * selectedMultiplier
    }
    
    var body: some View {
        List {
            if let selectedGame = selectedGameType {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(selectedGame.name)
                                .font(.title2)
                                .bold()
                            Spacer()
                            Text("\(selectedGame.baseValue)")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                        
                        Text(selectedGame.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Multiplikator")
                                .font(.headline)
                            
                            Picker("Multiplikator", selection: $selectedMultiplier) {
                                ForEach(selectedGame.multiplierOptions, id: \.self) { multiplier in
                                    Text("\(multiplier)").tag(multiplier)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Punktwert")
                                .font(.headline)
                            Spacer()
                            Text("\(calculatedPoints)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            
            Section(header: Text("Spielarten")) {
                ForEach(GameTypes.allTypes) { gameType in
                    Button {
                        withAnimation {
                            selectedGameType = gameType
                            selectedMultiplier = 1
                        }
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(gameType.name)
                                    .foregroundColor(.primary)
                                Text(gameType.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Text("\(gameType.baseValue)")
                                .foregroundColor(.secondary)
                        }
                    }
                    .background(
                        selectedGameType?.id == gameType.id ?
                        Color.accentColor.opacity(0.1) : Color.clear
                    )
                }
            }
        }
        .navigationTitle("Spielwerte")
    }
}

#Preview {
    NavigationStack {
        GameTypesView()
    }
}
