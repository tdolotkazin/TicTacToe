import Foundation
import TicTacToeAI

class TicTacToeViewModel: ObservableObject {
    @Published var board = Array(repeating: "", count: 9)
    @Published var isXTurn = true
    @Published var gameStatus: GameStatus = .playing
    @Published var moveCount = 0
    private let ai = TicTacToeAI()
    
    enum GameStatus {
        case playing
        case won
        case tie
    }
    
    func makeMove(at index: Int) {
        guard board[index].isEmpty && gameStatus == .playing else { return }
        
        board[index] = isXTurn ? "X" : "O"
        isXTurn.toggle()
        moveCount += 1
        
        checkGameStatus()
        
        // AI makes a move on even turns
        if !isXTurn && gameStatus == .playing {
            makeAIMove()
        }
    }
    
    private func makeAIMove() {
        if let bestMove = ai.findBestMove(board: board, player: "O") {
            board[bestMove] = "O"
            isXTurn.toggle()
            moveCount += 1
            checkGameStatus()
        }
    }
    
    func resetGame() {
        board = Array(repeating: "", count: 9)
        isXTurn = true
        gameStatus = .playing
        moveCount = 0
    }
    
    private func checkGameStatus() {
        // Check rows
        for i in stride(from: 0, to: 9, by: 3) {
            if !board[i].isEmpty && board[i] == board[i + 1] && board[i] == board[i + 2] {
                gameStatus = .won
                return
            }
        }
        
        // Check columns
        for i in 0..<3 {
            if !board[i].isEmpty && board[i] == board[i + 3] && board[i] == board[i + 6] {
                gameStatus = .won
                return
            }
        }
        
        // Check diagonals
        if !board[0].isEmpty && board[0] == board[4] && board[0] == board[8] {
            gameStatus = .won
            return
        }
        if !board[2].isEmpty && board[2] == board[4] && board[2] == board[6] {
            gameStatus = .won
            return
        }
        
        // Check for tie
        if !board.contains("") {
            gameStatus = .tie
        }
    }
} 
