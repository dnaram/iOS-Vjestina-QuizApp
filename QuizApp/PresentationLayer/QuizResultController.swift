//
//  QuizResultController.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.05.2021..
//

import SwiftUI
import PureLayout

class QuizResultViewController: UIViewController {
    
    private var resultLabel: UILabel!
    private var finishQuizButton: UIButton!
    
    private var correctlyAnswered: Int!
    private var numberOfQuestions: Int!
    
    let relativeFontConstant:CGFloat = 0.05
    
    init(correctlyAnswered: Int, numberOfQuestions: Int) {
        self.correctlyAnswered = correctlyAnswered
        self.numberOfQuestions = numberOfQuestions
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

        resultLabel = UILabel()
        resultLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        resultLabel.text = String(correctlyAnswered) + "/" + String(numberOfQuestions)
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont(name: "SourceSansPro-Black", size:100)
        resultLabel.textColor = .white

    
        finishQuizButton = UIButton()
        finishQuizButton.backgroundColor = .white
        finishQuizButton.setTitle("Finish Quiz", for: .normal)
        finishQuizButton.setTitleColor(UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 1), for: .normal)
        finishQuizButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        finishQuizButton.layer.cornerRadius = 22.0
        
        finishQuizButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        view.addSubview(resultLabel)
        view.addSubview(finishQuizButton)
    }

    private func addConstraints() {
        
        resultLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        resultLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        finishQuizButton.autoAlignAxis(toSuperviewAxis: .vertical)
        finishQuizButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 50)
        finishQuizButton.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
    }
    
    @objc
    private func logoutAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
