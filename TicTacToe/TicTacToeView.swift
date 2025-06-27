import SwiftUI

struct TicTacToeView: View {
    @StateObject private var viewModel = TicTacToeViewModel()
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .padding()
            
            Text(gameStatusText)
                .font(.title2)
                .foregroundColor(gameStatusColor)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(100), spacing: 5), count: 3), spacing: 5) {
                ForEach(0..<9) { index in
                    Button(action: {
                        viewModel.makeMove(at: index)
                    }) {
                        Text(viewModel.board[index])
                            .font(.system(size: 40, weight: .bold))
                            .frame(width: 100, height: 100)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(viewModel.board[index] == "X" ? .green : viewModel.board[index] == "O" ? .red : .blue)
                    }
                }
            }
            .padding()
            
            Button("Reset Game") {
                viewModel.resetGame()
            }
            .padding()
        }
    }
    
    private var gameStatusText: String {
        switch viewModel.gameStatus {
        case .playing:
            return "Current turn: \(viewModel.isXTurn ? "X" : "O")"
        case .won:
            return "Winner: \(viewModel.isXTurn ? "O" : "X")!"
        case .tie:
            return "Game ended in a tie!"
        }
    }
    
    private var gameStatusColor: Color {
        switch viewModel.gameStatus {
        case .playing:
            return .blue
        case .won:
            return .green
        case .tie:
            return .orange
        }
    }
}

#Preview {
    TicTacToeView()
} 