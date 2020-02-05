//
//  ViewController.swift
//  ViewPagerLayout
//
//  Created by rakesh.e.mishra on 04/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var pagerView: PagerView = {
        let pageView = PagerView(frame: .zero)
        pageView.backgroundColor = .green
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
            pagerView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
}

extension ViewController: PagerViewDelegate {

    func didSelectPagerTabItem(at index: Int) {
        print("selected tab item at index: \(index)")
    }
    
}
