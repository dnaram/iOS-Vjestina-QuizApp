//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Andrea Stanic on 14.04.2021..
//

import UIKit
import PureLayout

class LoginViewController: UIViewController {
    
    private var appNameLabel: UILabel!
    private var emailTextfield: UITextField!
    private var passwordTextField: UITextField!
    private var loginbutton: UIButton!
    private var unsuccessfulLogin: UILabel!
    
    private var networkService = NetworkService()
    
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

        appNameLabel = UILabel()
        appNameLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        appNameLabel.text = "PopQuiz"
        appNameLabel.textAlignment = .center
        appNameLabel.font = UIFont(name: "SourceSansPro-Black", size: 50)
        appNameLabel.textColor = .white

        emailTextfield = UITextField()
        emailTextfield.backgroundColor = .systemGray

        emailTextfield.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        emailTextfield.layer.cornerRadius = 21.0
        emailTextfield.layer.borderWidth = 1.0
        emailTextfield.layer.borderColor = UIColor.white.cgColor
        let redPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height:
                                                emailTextfield.frame.size.height))
        emailTextfield.leftView = redPaddingView
        emailTextfield.leftViewMode = .always
        emailTextfield.attributedPlaceholder = NSAttributedString(string: "Email",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextfield.textColor = .white
        
        emailTextfield.addTarget(self, action: #selector(hideLoginMessageAction), for: .editingDidBegin)
        
        passwordTextField = UITextField()
        passwordTextField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        passwordTextField.layer.cornerRadius = 21.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        let greenPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height:
                                                passwordTextField.frame.size.height))
        passwordTextField.leftView = greenPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .white
        
        passwordTextField.addTarget(self, action: #selector(hideLoginMessageAction), for: .editingDidBegin)

        loginbutton = UIButton()
        loginbutton.backgroundColor = .white
        loginbutton.setTitle("Login", for: .normal)
        loginbutton.setTitleColor(UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 1), for: .normal)
        loginbutton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        loginbutton.layer.cornerRadius = 22.0
        
        loginbutton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        unsuccessfulLogin = UILabel()
        unsuccessfulLogin.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        unsuccessfulLogin.text = "Incorrect username of password."
        unsuccessfulLogin.textAlignment = .center
        unsuccessfulLogin.font = UIFont(name: "SourceSansPro-Black", size: 20)
        unsuccessfulLogin.textColor = .systemRed
        unsuccessfulLogin.isHidden = true
        
        view.addSubview(appNameLabel)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextField)
        view.addSubview(loginbutton)
        view.addSubview(unsuccessfulLogin)
    }

    private func addConstraints() {
        
        appNameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        appNameLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        //appNameLabel.autoSetDimensions(to: CGSize(width: 140, height: 30))
        
        emailTextfield.autoCenterInSuperview()
        // emailTextfield.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        emailTextfield.autoMatch(.width, to: .width, of: view, withMultiplier: 0.8)
        emailTextfield.autoSetDimension(.height, toSize: 50)
        
        passwordTextField.autoAlignAxis(.vertical, toSameAxisOf: emailTextfield)
        passwordTextField.autoPinEdge(.top, to: .bottom, of: emailTextfield, withOffset: 20)
        passwordTextField.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        loginbutton.autoAlignAxis(.vertical, toSameAxisOf: passwordTextField)
        loginbutton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 20)
        loginbutton.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        unsuccessfulLogin.autoPinEdge(.top, to: .bottom, of: loginbutton, withOffset: 10)
        unsuccessfulLogin.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    @objc
    private func hideLoginMessageAction() {
        unsuccessfulLogin.isHidden = true
    }
    
    @objc
    private func loginAction() {
        let email = emailTextfield.text ?? " "
        let password = passwordTextField.text ?? " "
        
        let urlString = "https://iosquiz.herokuapp.com/api/session?password=" + password + "&username="+email
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        networkService.executeUrlRequest(request) { (result: Result<LoginResponse, RequestError>) in
            switch result {
            case .failure(let error):
                print ("Error:", error)
                self.unsuccessfulLogin.isHidden = false
            case .success(let value):
                let defaults = UserDefaults.standard
                defaults.setValue(value.id, forKey: "id")
                defaults.setValue(value.token, forKey: "token")
                self.navigationController?.popToRootViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.pushViewController(self.createTabBarViewController(), animated: true)
            }
        }
    }
    
    private func createTabBarViewController() -> UIViewController {
        let quizzesViewController = QuizzesViewController()
        quizzesViewController.tabBarItem.title = "Quizzes"
        quizzesViewController.tabBarItem = UITabBarItem(title: "Quizzes", image: .add, selectedImage: .add)

        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: .add, selectedImage: .add)


        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [quizzesViewController, settingsViewController]

        return tabBarViewController
    }
}
