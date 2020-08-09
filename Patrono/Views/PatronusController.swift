import Foundation

protocol PatronoControllerDelegate {
    func didFindPatronoResult(patrono: String, description: String)
}

class PatronoController {
    var delegate: PatronoControllerDelegate?
    
    private let answersSource = PatronoAnswers()
    private let patronoSource = PatronoResults()
    
    private var progress = Int()
    private var answers = [String]()
    private var result = [String]()
    private var patronoIndex = String()
    
    
    func checkPatronoAnswer(_ userAnswer: String) {
        if let answerIndex = answers.firstIndex(of: userAnswer) {
            let index = patronoIndex + String(answerIndex)
            patronoIndex = index
            
            for patrono in patronoSource.patronoResult where patrono.last == patronoIndex {
                result.append(patrono[0])
            }
            
            if let result = result.randomElement(),
                let description = getPatronusDescription(for: result) {
                delegate?.didFindPatronoResult(patrono: result, description: description)
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
    
    private func getPatronusDescription(for result: String) -> String? {
        guard let firstChar = result.first else { return nil }
        var description = String()
        
        if patronoIndex.count == 7 {
            description = isVowel(firstChar) ? Constants.rarePatronusDescriptionVowels : Constants.rarePatronusDescriptionConsonants
        } else if patronoIndex.count == 6 {
            description = isVowel(firstChar) ? Constants.unusualPatronusDescriptionVowels : Constants.unusualPatronusDescriptionConsonants
        } else {
            description = isVowel(firstChar) ? Constants.patronusDescriptionVowels : Constants.patronusDescriptionConsonants
        }
        return description
    }
    
    private func isVowel(_ char: Character) -> Bool {
        if char == "A" || char == "E" || char == "I" || char == "O" || char == "U" {
            return true
        } else { return false }
    }
}
