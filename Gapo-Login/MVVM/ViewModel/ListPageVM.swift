//
//  ListPageVM.swift
//  Gapo-Login
//
//  Created by Dung on 11/3/22.
//

import UIKit
import Alamofire
import RxSwift
import Action

class ListPageVM: ListViewModel<SFModel, CustomCellVM> {
    var searchResults = [DataItem]()
    
    var request: DataRequest?
    var isLoading: Bool = false
    private let pageSize: Int = 20
    var canLoadMore = true
    
    override func react() {
        reload()
    }
    
    func didGetItems(_ items: [DataItem], offset: Int) {
        let cellVMs = items.map({ CustomCellVM(model: $0) })
        if offset == 0 {
            itemsSource.reset([cellVMs], animated: false)
        } else {
            itemsSource.append(cellVMs, animated: false)
        }
        canLoadMore = items.isEmpty == false
    }
    
    func reload() {
        itemsSource.removeAll(animated: false)
        request?.cancel()
        isLoading = false
        getNotifications(offset: 0)
    }
    
    var allItems: [CustomCellVM] {
        return itemsSource.first?.allElements ?? []
    }
    
    var dataItems: [DataItem] {
        return allItems.compactMap({$0.model})
    }
    
    func loadMore() {
        guard canLoadMore else { return }
        let offset = allItems.count
        getNotifications(offset: offset)
    }
    // MARK: GET NOTIFICATION
    func getNotifications(offset: Int) {
        guard isLoading == false else { return }
        
        isLoading = true
        
        let parameters: [String:Any] = [
            "limit": pageSize,
            "offset": offset
        ]
        let headers: HTTPHeaders = ["Authorization": String(format: "Bearer %@", UserDefaults.standard.string(forKey: "accessToken")!),
                                    "x-gapo-lang": "Vie",
                                    "x-gapo-user-id": String(UserDefaults.standard.integer(forKey: "userID")),
                                    "x-gapo-workspace-id": "523866125265220"
                                    ]
        let request = AF.request("\(notiURL)/notifications",
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: headers)
        request.responseDecodable(of: Notification.self) { [weak self] response in
            if response.response?.statusCode == 200 {
                let notifications = response.value?.data ?? []
                print(response)
                self?.didGetItems(notifications, offset: offset)
            } else {
                print("Fail to get notification")
            }
            self?.isLoading = false
        }
        self.request = request
    }
    
    override func selectedItemDidChange(_ cellViewModel: CustomCellVM) {
        cellViewModel.updateState()
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        if searchText != "" {
            searchResults = dataItems.filter{ $0.message.text.lowercased().contains(searchText.lowercased()) }
        } else {
            searchResults = dataItems
        }
    }
}
