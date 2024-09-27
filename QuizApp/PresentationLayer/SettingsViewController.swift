//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Andrea Stanic on 04.05.2021..
//

import SwiftUI
import PureLayout

class SettingsViewController: UIViewController {
    
    private var usernameLabel: UILabel!
    private var userLabel: UILabel!
    private var logoutbutton: UIButton!
    
    let relativeFontConstant:CGFloat = 0.05

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
        
        usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        usernameLabel.text = "USERNAME"
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 18)
        usernameLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.75)

        userLabel = UILabel()
        userLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        userLabel.text = "Marko Andreis"
        userLabel.textAlignment = .center
        userLabel.font = UIFont(name: "SourceSansPro-Bold", size: 25)
        userLabel.textColor = .white

    
        logoutbutton = UIButton()
        logoutbutton.backgroundColor = .white
        logoutbutton.setTitle("Log out", for: .normal)
        logoutbutton.setTitleColor(UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1), for: .normal)
        logoutbutton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        logoutbutton.layer.cornerRadius = 22.0
        
        logoutbutton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        view.addSubview(userLabel)
        view.addSubview(usernameLabel)
        view.addSubview(logoutbutton)
    }

    private func addConstraints() {
        
        usernameLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 100)
        usernameLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 50)
        
        userLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 50)
        userLabel.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 5)
        
        logoutbutton.autoAlignAxis(toSuperviewAxis: .vertical)
        logoutbutton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 50)
        logoutbutton.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
    }
    
    @objc
    private func logoutAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
