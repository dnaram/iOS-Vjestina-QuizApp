//
//  QuestionTrackerView.swift
//  QuizApp
//
//  Created by Andrea Stanic on 04.06.2021..
//

import UIKit

class QuestionTrackerView: UIView {
    
    private var stackView: UIStackView!
    private var numberOfQuestions: Int!
    private var questions: [UIView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.numberOfQuestions = 5
        setup()
    }
    
    init(noOfQuestions: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.numberOfQuestions = noOfQuestions
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        questions = [UIView]()
        for question in 0...numberOfQuestions-1 {
            questions.append(makeRectangle(color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)))
            stackView.addArrangedSubview(questions[question])
        }
        
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        
    }
    
    private func makeRectangle(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 5
        return view
    }
    
    public func colorQuestion(question: Int, color: UIColor) {
        questions[question].backgroundColor = color
    }
}

