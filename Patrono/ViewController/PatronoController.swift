//
//  PatronoController.swift
//  Patrono
//
//  Created by Cintia Cavagnolli on 26/07/2020.
//  Copyright © 2020 Cintia Cavagnolli. All rights reserved.
//

import Foundation

protocol PatronoControllerDelegate {
    func didFindPatronoResult(patrono: String)
}

class PatronoController {
    
    var delegate: PatronoControllerDelegate?
    
    let answersSource = PatronoAnswers()
    let patronoSource = PatronoResults()
    
    var patrono: String?
    var progress = Int()
    var answers = [String]()
    var result = [String]()
    var patronoIndex = String()
    
    
    func checkPatronoAnswer(_ userAnswer: String) {
        if let answerIndex = answers.firstIndex(of: userAnswer) {
            let index = patronoIndex + String(answerIndex)
            patronoIndex = index
            
            for patrono in patronoSource.patronoResult where patrono.last == patronoIndex {
                result.append(patrono[0])
            }
            
            if let result = result.randomElement() {
                patrono = result
                delegate?.didFindPatronoResult(patrono: result)
            } else {
                progress += 1
            }
        }
        answers.removeAll()
    }
    
    func getPatronoAnswers() -> PatronoAnswersModel {
        if let answersSet = answersSource.patronoAnswers[progress].randomElement() {
            for answer in answersSet {
                answers.append(answer)
            }
        }
        return PatronoAnswersModel(answerOne: answers[0], answerTwo: answers[1], answerThree: answers[2])
    }
}
