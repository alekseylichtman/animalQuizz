//
//  QuestionViewController.swift
//  animalQuizz
//
//  Created by Oleksii Kolakovskyi on 10/14/19.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multipleAnswerLabel1: UILabel!
    @IBOutlet weak var multipleAnswerSwitch1: UISwitch!
    
    @IBOutlet weak var multipleAnswerLabel2: UILabel!
    @IBOutlet weak var multipleAnswerSwitch2: UISwitch!
    
    @IBOutlet weak var multipleAnswerLabel3: UILabel!
    @IBOutlet weak var multipleAnswerSwitch3: UISwitch!
    
    @IBOutlet weak var multipleAnswerLabel4: UILabel!
    @IBOutlet weak var multipleAnswerSwitch4: UISwitch!
    
    
    
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangeLabel1: UILabel!
    @IBOutlet weak var rangeLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    var answersChosen: [Answer] = []
    
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answers: [
            Answer(text: "🥩", type: .dog),
            Answer(text: "🐟", type: .cat),
            Answer(text: "🥕", type: .rabbit),
            Answer(text: "🌽", type: .turtle)
        ]),
        
        Question(text: "Which activities do you enjoy?", type: .multiple, answers: [
            Answer(text: "Swimming", type: .turtle),
            Answer(text: "Sleeping", type: .cat),
            Answer(text: "Cuddling", type: .rabbit),
            Answer(text: "Eating", type: .dog)
        ]),
        
        Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [
            Answer(text: "I dislike them", type: .cat),
            Answer(text: "I get a little nervous", type: .rabbit),
            Answer(text: "I barely notice them", type: .turtle),
            Answer(text: "I love them", type: .dog)
        ])
    ]
    
    var questionIndex = 0
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        button1.setTitle(answers[0].text, for: .normal)
        button2.setTitle(answers[1].text, for: .normal)
        button3.setTitle(answers[2].text, for: .normal)
        button4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleAnswerSwitch1.isOn = false
        multipleAnswerSwitch2.isOn = false
        multipleAnswerSwitch3.isOn = false
        multipleAnswerSwitch4.isOn = false
        
        multipleAnswerLabel1.text = answers[0].text
        multipleAnswerLabel2.text = answers[1].text
        multipleAnswerLabel3.text = answers[2].text
        multipleAnswerLabel4.text = answers[3].text
    }
    
    func updateRangeStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangeLabel1.text = answers.first?.text
        rangeLabel2.text = answers.last?.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    @IBAction func singleButton1tapped(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case button1:
            answersChosen.append(currentAnswers[0])
        case button2:
            answersChosen.append(currentAnswers[1])
        case button3:
            answersChosen.append(currentAnswers[2])
        case button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
       nextQuestion()
        
    }
    
    
    @IBAction func multipleAnswerButtonTapped(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        if multipleAnswerSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multipleAnswerSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multipleAnswerSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multipleAnswerSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangeStack(using: currentAnswers)
        }
        
    }
}


