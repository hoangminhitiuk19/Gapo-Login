//
//  CollectionListPage.swift
//  Gapo-Login
//
//  Created by Dung on 10/28/22.
//

import UIKit
import Alamofire
import RxSwift
import Action

class CollectionListPage: SFCollectionPage<ListPageVM>, UISearchBarDelegate {
    let searchController = UISearchController(searchResultsController: nil)
    let tabBar = UITabBarController()
    let padding: CGFloat = 20
    
    var isWaiting = false
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: INITIALIZE
    override func initialize() {
        super.initialize()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Collection List Page"
        collectionView.register(UINib(nibName: CustomCollectionCell.nibName,
                                      bundle: nil),
                                forCellWithReuseIdentifier: CustomCollectionCell.nibName)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        setupSearchBar()
    }
    
    override func bindViewAndViewModel() {
        super.bindViewAndViewModel()
    }
    
    @objc func refresh() {
        viewModel?.reload()
        refreshControl.endRefreshing()
    }
    
    override func cellIdentifier(_ cellViewModel: SFCollectionPage<ListPageVM>.CVM) -> String {
        return  CustomCollectionCell.nibName
    }
    
    private func setupSearchBar() {
          definesPresentationContext = true
          navigationItem.searchController = self.searchController
          navigationItem.hidesSearchBarWhenScrolling = false
          searchController.searchBar.delegate = self
          let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
          textFieldInsideSearchBar?.placeholder = "Tìm kiếm"
      }
    // MARK: COLLECTION VIEW
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if indexPath.row > viewModel.allItems.count - 2 {
            self.viewModel?.loadMore()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.frame.width
        let contentWidth = viewWidth
        let width = contentWidth
        return CGSize(width: width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

