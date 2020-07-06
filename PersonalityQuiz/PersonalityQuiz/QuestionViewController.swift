//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Pragnya Deshpande on 25/06/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    var answersChosen: [Answer] = []
    
    var questions: [Question] =
            [Question(text: "Which food do you like the most?", type: .single,
                      answers: [Answer(text: "Cookies", type: .dog), Answer(text: "Milk", type: .cat), Answer(text: "Carrots", type: .rabbit), Answer(text: "Corn", type: .turtle)]),
             Question(text: "Which activities do you enjoy", type: .multiple,
                      answers: [Answer(text: "Swimming", type: .turtle), Answer(text: "Sleeping", type: .cat), Answer(text: "Cuddling", type: .dog), Answer(text: "Eating", type: .rabbit)]),
                Question(text: "How much do you enjoy car rides", type: .ranged,
                         answers: [Answer(text:"I dislike them" , type: .cat), Answer(text: "I get a little nervous", type: .rabbit), Answer(text: "I don't mind them", type: .turtle), Answer(text: "I love them", type: .dog)])]
    var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let thisAnswer = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(thisAnswer[0])
        case singleButton2:
            answersChosen.append(thisAnswer[1])
        case singleButton3:
            answersChosen.append(thisAnswer[2])
        case singleButton4:
            answersChosen.append(thisAnswer[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let theseAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn{
            answersChosen.append(theseAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(theseAnswers[1])
        }
        if multiSwitch3.isOn{
            answersChosen.append(theseAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(theseAnswers[3])
        }
    }
   
    @IBAction func multiAnswerSubmitted(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        rangedSlider.isContinuous = false
        let currentAnswers = questions[questionIndex].answers
        var index:Int = 0
        let tempValue = Int(rangedSlider.value)
        if  tempValue <= 25{
            index = 0} else if tempValue <= 50{
            index = 1} else if tempValue <= 75{
            index = 2} else if tempValue <= 100{
            index = 3}
        answersChosen.append(currentAnswers[index])
    }
    
    @IBAction func rangedAnswerSubmitted(_ sender: Any) {
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex<questions.count{
            UpdateUI()
        }else{
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
func UpdateUI() {
    singleStackView.isHidden = true
    multipleStackView.isHidden = true
    rangedStackView.isHidden = true
    
    let currentQuestion = questions[questionIndex]
    let currentAnswer = currentQuestion.answers
    let totalProgress = Float(questionIndex)/Float(questions.count)
    
    navigationItem.title = "Question#\(questionIndex+1)"
    questionLabel.text = currentQuestion.text
    questionProgressView.setProgress(totalProgress, animated: true)
    
    switch currentQuestion.type {
    case .single:
        UpdateSingleStack(using: currentAnswer)
    case .multiple:
        UpdateMultiStack(using: currentAnswer)
    case .ranged:
        UpdateRangedStack(using: currentAnswer)
    }
   }
    
    func UpdateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func UpdateMultiStack(using answers: [Answer]) {
         multipleStackView.isHidden = false
         multiSwitch1.isOn = false
         multiSwitch2.isOn = false
         multiSwitch3.isOn = false
         multiSwitch4.isOn = false
         
         multiLabel1.text = answers[0].text
         multiLabel2.text = answers[1].text
         multiLabel3.text = answers[2].text
         multiLabel4.text = answers[3].text
    }
    
    func UpdateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue"{
            let temporaryDataHolder = segue.destination as! ResultViewController
            temporaryDataHolder.responses = answersChosen
        }
    }
}
