//
//  NotificationListPage.swift
//  Gapo-Login
//
//  Created by Dung on 9/28/22.
//

import UIKit
import Action
import RxCocoa
import Alamofire

class TableListPage: SFListPage<ListPageVM>,
                            UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    let tabBar = UITabBarController()
    var isWaiting = false

    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    
    override func initialize() {
        super.initialize()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Table List Page"
        tableView.registerNibsWith(names: [
            CustomTableCell.nibName
        ])
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        setupSearchBar()
    }
    
    
    override func bindViewAndViewModel() {
        super.bindViewAndViewModel()
    }
    
    @objc func refresh() {
        viewModel?.reload()
        refreshControl.endRefreshing()
    }
    
    // MARK: - TableView
    
    override func cellIdentifier(_ cellViewModel: SFListPage<ListPageVM>.CVM) -> String {
        return  CustomTableCell.nibName
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func setupSearchBar() {
          definesPresentationContext = true
          navigationItem.searchController = self.searchController
          navigationItem.hidesSearchBarWhenScrolling = false
          searchController.searchBar.delegate = self
          let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
          textFieldInsideSearchBar?.placeholder = "Tìm kiếm"
      }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if indexPath.row > viewModel.allItems.count - 2 {
            self.viewModel?.loadMore()
        }
    }
}


// MARK: EXTENSION UISCROLLVIEW
extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}
