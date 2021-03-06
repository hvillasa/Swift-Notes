//
//  PinterestLayoutViewController.swift
//  InsetItemGrid
//
//  Created by s on 2/23/20.
//  Copyright © 2020 s. All rights reserved.
//

import UIKit

class PinterestLayoutViewController: UIViewController {
    var colors: [UIColor] = [.black, .orange, .systemBlue, .systemPink, .systemPurple, .brown, .systemTeal, .black, .systemPink, .systemBlue, .systemPink, .red, .brown, .systemTeal ,.black, .orange, .systemBlue, .systemPink, .systemPurple, .brown, .systemTeal, .black, .systemPink, .systemBlue, .systemPink, .red, .brown, .systemTeal]
    var sizes: [CGFloat] = []
    enum Section {
        case main
        case main2
    }

    private var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        createCollectionView()
        configureDateSource()

    }

    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: PinterestLayout())

        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }

        collectionView.backgroundColor = .gray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    private func configureDateSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, i -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.backgroundColor = self.colors[i]//self.colors.randomElement()
            let cornernRadius: CGFloat = 8
            cell.layer.cornerRadius = cornernRadius
            cell.contentView.layer.cornerRadius = cornernRadius
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.white.cgColor
            return cell
        })

        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()

        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0..<colors.count))

        for _ in snapShot.itemIdentifiers {
            sizes.append(CGFloat.random(in: 150...340))
        }

        dataSource.apply(snapShot, animatingDifferences: false)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
}


extension PinterestLayoutViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return sizes[indexPath.item]
    }
}
