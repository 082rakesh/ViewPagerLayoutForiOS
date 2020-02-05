//
//  ViewController.swift
//  ViewPagerLayout
//
//  Created by rakesh.e.mishra on 04/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let pagerItems = ["Testing large content", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "item9", "item10"]

    private lazy var pagerView: PagerView = {
        let pageView = PagerView(tabItems: self.pagerItems)
        pageView.delegate = self
        return pageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(pagerView)
        setupViewPagerConstraints()
    }

    private func setupViewPagerConstraints() {
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pagerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            pagerView.heightAnchor.constraint(equalToConstant: 75.0)
        ])
    }
}

extension ViewController: PagerViewDelegate {

    func didSelectPagerTabItem(at index: Int) {
        print("selected tab item at index: \(index)")
    }
}
