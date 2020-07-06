//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Pragnya Deshpande on 25/06/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var responses: [Answer]!
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultAnswerDefinition: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateResult()
    }

    func calculateResult(){
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map{ $0.type }
        for r in responseTypes{
            frequencyOfAnswers[r] = (frequencyOfAnswers[r] ?? 0)+1
        }
        let frequencyOflAnswerSorted = frequencyOfAnswers.sorted(by:
        {
            (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        let finalAnswer = frequencyOflAnswerSorted.first?.key
        
        resultAnswerLabel.text = "You are a \(finalAnswer!.rawValue)!"
        resultAnswerDefinition.text = finalAnswer?.definition
    }
}
