//
//  ViewController.swift
//  ApplePie
//
//  Created by Pragnya Deshpande on 25/04/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit

var listOfWords = ["pasta","ragda pattis","paani puri","cake","pav bhaji", "pancakes", "dalgona coffee", "sandwich","palak paneer"]
let incorrectMovesAllowed = 7

class ViewController: UIViewController {
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame : Game!
    
    func newRound(){
        if !listOfWords.isEmpty {
                let newWord = listOfWords.removeFirst()
                currentGame = Game(word: newWord,
                incorrectMovesRemaining: incorrectMovesAllowed,
                guessedLetters: [])
                enableLetterButtons(true)
                updateUI()
            } else {
                enableLetterButtons(false)
            }
    }

    func updateUI(){
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState()  {
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }else{
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
      for button in letterButtons {
        button.isEnabled = enable
      }
    }
    
}

