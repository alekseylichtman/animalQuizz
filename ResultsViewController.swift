//
//  ResultsViewController.swift
//  animalQuizz
//
//  Created by Oleksii Kolakovskyi on 10/14/19.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var responses: [Answer]!
    
    @IBOutlet weak var resultsTitle: UILabel!
    
    @IBOutlet weak var resultsDefinition: UILabel!
    
    
    
    
    
    func calculatePersonalityResult() {
      var frequencyOfAnswers: [AnimalType: Int] = [:]

    
    let responseTypes = responses.map { $0.type }
    
    for response in responseTypes {
        frequencyOfAnswers[response] = (frequencyOfAnswers[response]
    ?? 0) + 1
}

    let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 >
    $1.1 }.first!.key
        
    resultsTitle.text = "\(mostCommonAnswer.rawValue)"
    resultsDefinition.text = mostCommonAnswer.definition

   }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
