//
//  SearchBarView.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//

import SwiftUI

class SearchBarView: UIView {
    
    private var searchText: UITextField!
    private var searchButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        searchText = UITextField()
        searchText.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        searchText.layer.cornerRadius = 21.0
        searchText.layer.borderWidth = 1.0
        searchText.layer.borderColor = UIColor.white.cgColor
        let searchTextPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height:
                                                searchText.frame.size.height))
        searchText.leftView = searchTextPaddingView
        searchText.leftViewMode = .always
        searchText.attributedPlaceholder = NSAttributedString(string: "Type here",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchText.textColor = .white
        searchText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        searchButton = UIButton()
        searchButton.backgroundColor = .none
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        searchButton.layer.cornerRadius = 22.0
        
        stackView.addArrangedSubview(searchText)
        stackView.addArrangedSubview(searchButton)
        
        stackView.autoPinEdgesToSuperviewEdges()
    }
    
    public func getSearchButton() -> UIButton {
        return searchButton
    }

}

