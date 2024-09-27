//
//  SearchViewControler.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//

import UIKit
import PureLayout

class SearchViewController: UIViewController {
    
    let relativeFontConstant:CGFloat = 0.05
    
    private var searchBarView: SearchBarView!

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
        
        searchBarView = SearchBarView()
        searchBarView.getSearchButton().addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        view.addSubview(searchBarView)
    }

    private func addConstraints() {

        searchBarView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        searchBarView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        searchBarView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        searchBarView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
    }
    
    @objc
    private func searchAction() {
        print ("button pressed")
    }
}
