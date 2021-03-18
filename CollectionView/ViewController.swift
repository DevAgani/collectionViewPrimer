//
//  ViewController.swift
//  CollectionView
//
//  Created by George Nyakundi on 16/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var datasource : UICollectionViewDiffableDataSource<Section,Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = configureCollectionView()
        configureDataSource()
        // Do any additional setup after loading the view.
    }
    
    func configureCollectionView() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section,Int>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
            //dequeue a reusable cell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else {
                fatalError("Cannot create new cell")
            }
            
            cell.label.text = number.description
            return cell
        })
        
        //initial Snapshot
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section,Int>()
        initialSnapshot.appendSections([.main])
        //add items to section
        initialSnapshot.appendItems(Array(1...100))
        
        
        datasource.apply(initialSnapshot, animatingDifferences: false)
    }


}

