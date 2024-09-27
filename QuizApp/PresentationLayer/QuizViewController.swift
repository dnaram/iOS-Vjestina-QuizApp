//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.05.2021..
//

import SwiftUI
import PureLayout

class QuizViewController: UIViewController {
    
    private var currentQuestionLabel: UILabel!
    private var questionLabel: UILabel!
    private var answer1Button: UIButton!
    private var answer2Button: UIButton!
    private var answer3Button: UIButton!
    private var answer4Button: UIButton!
    private var answerButtons: [UIButton]!
    
    private var questionTracker: QuestionTrackerView!
    
    private var quiz : Quiz!
    private var currentQuestion = 1
    private var correctlyAnswered = 0
    
    let relativeFontConstant:CGFloat = 0.05
    
    init(quiz: Quiz) {
        self.quiz = quiz
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        addConstraints()
    }

    private func buildViews() {
    
        view.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 1)
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
          UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1.95, b: 1.41, c: -1.41, d: -0.41, tx: 2.02, ty: -0.01))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        
        currentQuestionLabel = UILabel()
        currentQuestionLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        
        
        currentQuestionLabel.text = String(currentQuestion) + "/" + String(quiz.questions.count)
        currentQuestionLabel.font = UIFont(name: "SourceSansPro-Black", size: 18)
        currentQuestionLabel.textColor = .white

        questionLabel = UILabel()
        questionLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        questionLabel.text = quiz.questions[currentQuestion-1].question
        questionLabel.textAlignment = .left
        questionLabel.font = UIFont(name: "SourceSansPro-Black", size:24)
        questionLabel.textColor = .white
        
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0

    
        answer1Button = UIButton()
        answer1Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        let answer1 = quiz.questions[currentQuestion-1].answers[0]
        answer1Button.setTitle(answer1, for: .normal)
        answer1Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer1Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer1Button.layer.cornerRadius = 22.0
        answer1Button.contentHorizontalAlignment = .left
        answer1Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer1Button.addTarget(self, action: #selector(answerAction), for: .touchUpInside)
        
        
        answer2Button = UIButton()
        answer2Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        let answer2 = quiz.questions[currentQuestion-1].answers[1]
        answer2Button.setTitle(answer2, for: .normal)
        answer2Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer2Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer2Button.layer.cornerRadius = 22.0
        answer2Button.contentHorizontalAlignment = .left
        answer2Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer2Button.addTarget(self, action: #selector(answerAction), for: .touchUpInside)
        
        
        answer3Button = UIButton()
        answer3Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        let answer3 = quiz.questions[currentQuestion-1].answers[2]
        answer3Button.setTitle(answer3, for: .normal)
        answer3Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer3Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer3Button.layer.cornerRadius = 22.0
        answer3Button.contentHorizontalAlignment = .left
        answer3Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer3Button.addTarget(self, action: #selector(answerAction), for: .touchUpInside)
        
        
        answer4Button = UIButton()
        answer4Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        let answer4 = quiz.questions[currentQuestion-1].answers[3]
        answer4Button.setTitle(answer4, for: .normal)
        answer4Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer4Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer4Button.layer.cornerRadius = 22.0
        answer4Button.contentHorizontalAlignment = .left
        answer4Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer4Button.addTarget(self, action: #selector(answerAction), for: .touchUpInside)
        
        answerButtons = [UIButton]()
        answerButtons.append(answer1Button)
        answerButtons.append(answer2Button)
        answerButtons.append(answer3Button)
        answerButtons.append(answer4Button)
        
        questionTracker = QuestionTrackerView(noOfQuestions: 10)
        view.addSubview(questionTracker)
        
        view.addSubview(currentQuestionLabel)
        view.addSubview(questionLabel)
        view.addSubview(answer1Button)
        view.addSubview(answer2Button)
        view.addSubview(answer3Button)
        view.addSubview(answer4Button)
    }
    
    private func makeRectangle(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 5
        return view
    }


    private func addConstraints() {
        
        currentQuestionLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        currentQuestionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        questionTracker.autoPinEdge(.top, to: .bottom, of: currentQuestionLabel, withOffset: 20)
        questionTracker.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        questionTracker.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        questionTracker.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 10))
        
        questionLabel.autoPinEdge(.top, to: .bottom, of: questionTracker, withOffset: 30)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        questionLabel.sizeToFit()
        
        answer1Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer1Button.autoPinEdge(.top, to: .bottom, of: questionLabel, withOffset: 40)
        answer1Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer1Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer1Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        answer2Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer2Button.autoPinEdge(.top, to: .bottom, of: answer1Button, withOffset: 15)
        answer2Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer2Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer2Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        answer3Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer3Button.autoPinEdge(.top, to: .bottom, of: answer2Button, withOffset: 15)
        answer3Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer3Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer3Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        answer4Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer4Button.autoPinEdge(.top, to: .bottom, of: answer3Button, withOffset: 15)
        answer4Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer4Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer4Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
    
    }
    
    @objc
    private func answerAction(sender: UIButton) {
        let chosenAnswer = sender.titleLabel!.text!
        let correctAnswer = quiz.questions[currentQuestion-1].answers[quiz.questions[currentQuestion-1].correctAnswer]
        if (chosenAnswer == correctAnswer) {
            sender.backgroundColor = .systemGreen
            self.questionTracker.colorQuestion(question: self.currentQuestion-1, color: .systemGreen)
            self.correctlyAnswered += 1
        } else {
            sender.backgroundColor = .systemRed
            self.answerButtons[self.quiz.questions[self.currentQuestion-1].correctAnswer].backgroundColor = .systemGreen
            self.questionTracker.colorQuestion(question: self.currentQuestion-1, color: .systemRed)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            sender.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
            self.answerButtons[self.quiz.questions[self.currentQuestion-1].correctAnswer].backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
            self.currentQuestion += 1
            
            if (self.currentQuestion > self.quiz.questions.count) {
                let quizResultViewController = QuizResultViewController(correctlyAnswered: self.correctlyAnswered, numberOfQuestions: self.quiz.questions.count)
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.pushViewController(quizResultViewController, animated: true)
                return
            }
            
            self.currentQuestionLabel.text = String(self.currentQuestion) + "/" + String(self.quiz.questions.count)
            self.questionLabel.text = self.quiz.questions[self.currentQuestion-1].question
            let answer1 = self.quiz.questions[self.currentQuestion-1].answers[0]
            self.answer1Button.setTitle(answer1, for: .normal)
            let answer2 = self.quiz.questions[self.currentQuestion-1].answers[1]
            self.answer2Button.setTitle(answer2, for: .normal)
            let answer3 = self.quiz.questions[self.currentQuestion-1].answers[2]
            self.answer3Button.setTitle(answer3, for: .normal)
            let answer4 = self.quiz.questions[self.currentQuestion-1].answers[3]
            self.answer4Button.setTitle(answer4, for: .normal)
        }
    }
}


