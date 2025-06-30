import Foundation

public class TicTacToeAI {

    public init() {}
    
    public func findBestMove(board: [String], player: String) -> Int? {
        // Try to win
        if let winningMove = findWinningMove(board: board, for: player) {
            return winningMove
        }

        // Block opponent's winning move
        let opponent = player == "X" ? "O" : "X"
        if let blockingMove = findWinningMove(board: board, for: opponent) {
            return blockingMove
        }

        // Take center if available
        if board[4].isEmpty {
            return 4
        }

        // Take a corner if available
        let corners = [0, 2, 6, 8]
        if let availableCorner = corners.first(where: { board[$0].isEmpty }) {
            return availableCorner
        }

        // Take any remaining space
        return board.firstIndex(where: { $0.isEmpty })
    }

    private func findWinningMove(board: [String], for player: String) -> Int? {
        // Check each empty position
        for i in 0..<9 where board[i].isEmpty {
            // Try the move
            var tempBoard = board
            tempBoard[i] = player

            // Check if this move would win
            if checkWinningMove(board: tempBoard, for: player) {
                return i
            }
        }
        return nil
    }

    private func checkWinningMove(board: [String], for player: String) -> Bool {
        // Check rows
        for i in stride(from: 0, to: 9, by: 3) {
            if board[i] == player && board[i + 1] == player && board[i + 2] == player {
                return true
            }
        }

        // Check columns
        for i in 0..<3 {
            if board[i] == player && board[i + 3] == player && board[i + 6] == player {
                return true
            }
        }

        // Check diagonals
        if board[0] == player && board[4] == player && board[8] == player {
            return true
        }
        if board[2] == player && board[4] == player && board[6] == player {
            return true
        }

        return false
    }
}
