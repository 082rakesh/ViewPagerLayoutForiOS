//
//  PagerView.swift
//  ViewPagerLayout
//
//  Created by rakesh.e.mishra on 04/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import UIKit

protocol PagerViewDelegate: class {
    func didSelectPagerTabItem(at index: Int)
}

class PagerView: UIView {

    private let trailingTitleInset = 50.0
    private let cellIdentifier = "reusableCell"
    private let pagerItems: [String]
    weak var delegate: PagerViewDelegate?

    private var selectedIndexPath: IndexPath?

    private var defaultSelectedIndexPath: IndexPath? {
        return IndexPath(item: 0, section: 0)
    }

    private var previouslySelectedIndexPath: IndexPath {
           guard let currentlySelectedIndex = selectedIndexPath else { return IndexPath(item: 0, section: 0) }
           return currentlySelectedIndex
    }


    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10.0

        let lCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        lCollectionView.showsHorizontalScrollIndicator = false
        return lCollectionView
    }()
    
    init(tabItems: [String]) {
        self.pagerItems = tabItems
        super.init(frame: .zero)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .gray
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PagerItemCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 0.0, right: 20.0)
        setupDefaultCell()

    }

    private func setupDefaultCell() {

        if let selectedIndexPath = defaultSelectedIndexPath,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? PagerItemCollectionCell {
            selectedCell.textColor = .red
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
        }
    }
}

extension PagerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagerItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PagerItemCollectionCell
            else { return UICollectionViewCell() }
        cell.setupItemLabel(with: pagerItems[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  itemWidth(at: indexPath)

        return CGSize(width: width, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? PagerItemCollectionCell,
            let previouslySelectedIndexPath = collectionView.cellForItem(at: previouslySelectedIndexPath) as? PagerItemCollectionCell {

            if shouldItemSelect(at: indexPath) {
                selectItem(at: indexPath)
                selectedCell.textColor = .red
                previouslySelectedIndexPath.textColor = .black
                delegate?.didSelectPagerTabItem(at: indexPath.item)
            }
        }
    }

    func itemWidth(at indexPath: IndexPath) -> CGFloat {
        let size = (pagerItems[indexPath.item] as NSString).size(withAttributes: nil)
        let itemWidth = size.width + CGFloat(trailingTitleInset)

        return itemWidth
    }

    func shouldItemSelect(at indexPath: IndexPath) -> Bool {
        if let currentlySelectedIndex = selectedIndexPath, currentlySelectedIndex == indexPath { return false }
        return true
    }

    func selectItem(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
}
