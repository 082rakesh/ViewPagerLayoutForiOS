//
//  PagerView.swift
//  ViewPagerLayout
//
//  Created by rakesh.e.mishra on 04/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import UIKit

class PagerView: UIView {
    
    private let trailingTitleInset = 50.0
    let pagerItems = ["Testing large content", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "item9", "item10"]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10.0

        let lCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        lCollectionView.showsHorizontalScrollIndicator = false

        return lCollectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .red
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PagerItemCollectionCell.self, forCellWithReuseIdentifier: "reusableCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 0.0, right: 20.0)
    }
}

extension PagerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagerItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusableCell", for: indexPath) as? PagerItemCollectionCell
            else { return UICollectionViewCell() }
        cell.setupItemLabel(with: pagerItems[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  itemWidth(at: indexPath)
        return CGSize(width: width, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select at: \(pagerItems[indexPath.item])")
    }
    
    func itemWidth(at indexPath: IndexPath) -> CGFloat {
        let size = (pagerItems[indexPath.item] as NSString).size(withAttributes: nil)
        let itemWidth = size.width + CGFloat(trailingTitleInset)
        return itemWidth
    }
}
