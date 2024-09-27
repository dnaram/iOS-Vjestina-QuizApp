//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Andrea Stanic on 14.04.2021..
//

import UIKit
import CoreData

class QuizzesViewController: UIViewController {
    
    private var appNameLabel: UILabel!
    private var lightbulbImage: UIImageView!
    private var circleImage: UIImageView!
    private var getQuizButton: UIButton!
    private var funFactLabel: UILabel!
    private var infoLabel: UILabel!
    
    let cellIdentifier = "cellId"
    private var tableView: UITableView!
    
    private var byCategory: Dictionary<QuizCategory, [Quiz]> = [:]
    private var sectionToCategory = [QuizCategory]()
    
    private var networkService = NetworkService()
    
    let relativeFontConstant:CGFloat = 0.05
    let relativeFontFunFactConstant:CGFloat = 0.025
    let relativeInfoConstant:CGFloat = 0.015

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
        appNameLabel.font = UIFont(name: "SourceSansPro-Black", size: 30)
        appNameLabel.textColor = .white

        getQuizButton = UIButton()
        getQuizButton.backgroundColor = .white
        getQuizButton.setTitle("Get Quiz", for: .normal)
        getQuizButton.setTitleColor(UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 1), for: .normal)
        getQuizButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        getQuizButton.layer.cornerRadius = 22.0
        
        getQuizButton.addTarget(self, action: #selector(getQuizAction), for: .touchUpInside)
        
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 20.0, weight: .heavy)
        let lightbulb = UIImage(systemName: "lightbulb", withConfiguration: configuration)
        lightbulbImage = UIImageView(image: lightbulb)
        lightbulbImage.tintColor = .white
        lightbulbImage.isHidden = true
    
        
        funFactLabel = UILabel()
        funFactLabel.text = "Fun Fact"
        funFactLabel.textColor = .white
        funFactLabel.font = UIFont(name: "SourceSansPro-Black", size: UIScreen.main.bounds.height * relativeFontFunFactConstant)
        funFactLabel.isHidden = true
        
        infoLabel = UILabel()
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        infoLabel.numberOfLines = 0
        // infoLabel.isHidden = true
        
        
        
        
        
        // set up za tablicu --------------
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = true
        tableView.backgroundColor = .clear
        // set up za tablicu --------------
        
        
        
        // podatci vezani za kvizove
        
        
        
        // podatci vezani za kvizove
      
        navigationItem.hidesBackButton = true
        
        
    
        view.addSubview(infoLabel)
        view.addSubview(funFactLabel)
        view.addSubview(lightbulbImage)
        view.addSubview(appNameLabel)
        view.addSubview(getQuizButton)
    }

    private func addConstraints() {
        
        appNameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        appNameLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 30)
        //appNameLabel.autoSetDimensions(to: CGSize(width: 140, height: 30))
        
        getQuizButton.autoAlignAxis(.vertical, toSameAxisOf: appNameLabel)
        getQuizButton.autoPinEdge(.top, to: .bottom, of: appNameLabel, withOffset: 20)
        getQuizButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        getQuizButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
        getQuizButton.autoSetDimensions(to: CGSize(width: 30, height: 50))
        
        lightbulbImage.autoPinEdge(.leading, to: .leading, of: getQuizButton)
        lightbulbImage.autoPinEdge(.top, to: .bottom, of: getQuizButton, withOffset: 25)
        
        
        funFactLabel.autoPinEdge(.leading, to: .trailing, of: lightbulbImage, withOffset: 10)
        funFactLabel.autoPinEdge(.top, to: .bottom, of: getQuizButton, withOffset: 25)
        // funFactLabel.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 15))
        
        infoLabel.autoPinEdge(.leading, to: .leading, of: getQuizButton)
        infoLabel.autoPinEdge(.top, to: .bottom, of: funFactLabel, withOffset: 5)
        infoLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
        // infoLabel.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 15))
        
        tableView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        tableView.autoPinEdge(.top, to: .bottom, of: infoLabel, withOffset: 20)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
        tableView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)

    }
    
    @objc
    private func getQuizAction() {
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        DispatchQueue.global(qos: .userInitiated).async {
        NetworkService().executeUrlRequest(request) { (result: Result<QuizzesResponse, RequestError>) in
            var quizzes: [Quiz]
            switch result {
            case .failure(let error):
                print ("Error:", error)
                return
            case .success(let value):
                quizzes = value.quizzes
                let totalNBA = quizzes.map{ $0.questions }.flatMap{ $0 }.map{ $0.question }.filter{ $0.contains("NBA")}.reduce(0, {x, y in x + 1})
                self.infoLabel.text = "There are " + String(totalNBA) + " questions that contain the word \"NBA\""
                self.funFactLabel.isHidden = false
                self.infoLabel.isHidden = false
                self.lightbulbImage.isHidden = false
                self.tableView.isHidden = false
                
                self.byCategory.removeAll()
                self.sectionToCategory.removeAll()
                for quiz in quizzes {
                    var list = self.byCategory[quiz.category] ?? []
                    if (list.isEmpty) {
                        list = [Quiz]()
                    } else {
                        list = self.byCategory[quiz.category] ?? []
                    }
                    list.append(quiz)
                    self.byCategory[quiz.category] = list
                }
                
                for category in self.byCategory {
                    self.sectionToCategory.append(category.key)
                }
            
                self.tableView.reloadData()
            }
        }
        }
    }
}


extension QuizzesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return byCategory[sectionToCategory[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let text = byCategory[sectionToCategory[indexPath.section]]![indexPath.row].title.uppercased() + "\n\n" + byCategory[sectionToCategory[indexPath.section]]![indexPath.row].description
    
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont(name: "SourceSansPro-Black", size: 15)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(named: "sport2")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        
       
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .black)
        let circle = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        circleImage = UIImageView(image: circle)
        let level = byCategory[sectionToCategory[indexPath.section]]![indexPath.row].level
        if level == 1 {
            circleImage.tintColor = .systemGreen
        } else if level == 2 {
            circleImage.tintColor = .systemOrange
        } else {
            circleImage.tintColor = .systemRed
        }
        cell.accessoryView = circleImage
        cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        cell.layer.cornerRadius = 20
        cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 100, left: 10, bottom: 10, right: 10))
        cell.clipsToBounds = true

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return byCategory.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = .clear
        
        headerView.text = sectionToCategory[section].rawValue.lowercased().capitalized
        headerView.textColor = .white
        headerView.font = UIFont(name: "SourceSansPro-Black", size: 20)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quiz = byCategory[sectionToCategory[indexPath.section]]![indexPath.row]
        let quizViewController = QuizViewController(quiz: quiz)
        self.navigationController?.pushViewController(quizViewController, animated: true)
    }
    
}


