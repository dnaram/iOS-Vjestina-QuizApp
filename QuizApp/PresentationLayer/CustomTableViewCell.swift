//
//  CustomTableViewCell.swift
//  QuizApp
//
//  Created by Andrea Stanic on 14.04.2021..
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"
    
    private let quizNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Quiz Name"
        return label
    }()
    
    private let quizDescLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Quiz Desc"
        return label
    }()
    
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sport.jpeg")
        // imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        contentView.layer.cornerRadius = 20
        
        
        contentView.addSubview(quizDescLabel)
        contentView.addSubview(quizNameLabel)
        contentView.addSubview(myImageView)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(name: String, desc: String, imageName: String) {
        quizNameLabel.text = name
        quizDescLabel.text = desc
        
        quizDescLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        quizDescLabel.numberOfLines = 3
        quizDescLabel.translatesAutoresizingMaskIntoConstraints = false
        myImageView.image = UIImage(named: imageName)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        quizNameLabel.text = nil
        myImageView.image = nil
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func addConstraints() {
        
        myImageView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        myImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        myImageView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.height * 0.15, height: UIScreen.main.bounds.size.height * 0.15))
        
        quizNameLabel.autoPinEdge(.leading, to: .trailing, of: myImageView, withOffset: 20)
        quizNameLabel.autoPinEdge(.top, to: .top, of: myImageView, withOffset: 10)
        
        quizDescLabel.autoPinEdge(.leading, to: .trailing, of: myImageView, withOffset: 20)
        quizDescLabel.autoPinEdge(.top, to: .bottom, of: quizNameLabel, withOffset: 15)
        quizDescLabel.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.4, height: 100))
        
    }
    
}
