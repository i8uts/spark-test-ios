//
//  ViewController.swift
//  spark-test-ios
//
//  Created by Ihor Buts on 07.04.2025.
//

import UIKit

// - collection view hScroll
// H[-collectionView-]
// V.center
// height 150


class ViewController: UIViewController {
    var itemsCount = 0
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        setupCollectionView()
        addTapHandler()
    }

    func addTapHandler() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        recognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(recognizer)
    }

    @objc
    func tapped() {
        itemsCount += 1
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: itemsCount - 1, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
    }

    func removeItem(at position: Int) {
        itemsCount -= 1
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [.init(row: position, section: 0)])
        }
    }

    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collectionView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        ])
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifer")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        removeItem(at: indexPath.row)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifer", for: indexPath)
        cell.contentView.backgroundColor = .red
        return cell
    }
}

