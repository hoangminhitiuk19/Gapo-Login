//
//  NotificationCollectionController.swift
//  Gapo-Login
//
//  Created by Dung on 9/23/22.
//

import UIKit
import Alamofire
import SDWebImage

class NotificationCollectionController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let tabBar = UITabBarController()
    var notifications = [DataItem]()
    var searchResults = [DataItem]()
    //-----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Thông báo"
        navigationController?.navigationBar.prefersLargeTitles = true
        getNotifications()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.registerCollectionViewCells()
        setupSearchBar()
        searchResults = notifications
        self.tabBarItem.title = "Thông báo"
    }
    //-----------------------------------------
    private func registerCollectionViewCells() {
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
    //-----------------------------------------
    func getNotifications() {
        let parameters: [String:Any] = [
            "limit": 20,
            "offset": 0
        ]
        let headers: HTTPHeaders = ["Authorization": String(format: "Bearer %@",
                                                            UserDefaults.standard.string(forKey: "accessToken")!),
                                    "x-gapo-lang": "Vie",
                                    "x-gapo-user-id": String(UserDefaults.standard.integer(forKey: "userID")),
                                    "x-gapo-workspace-id": "523866125265220"
                ]
        let request = AF.request("\(notiURL)/notifications",
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: headers)
        request.responseDecodable(of: Notification.self) { [self] response in
            if response.response?.statusCode == 200 {
                self.notifications = response.value?.data ?? []
                self.collectionView.reloadData()
            } else {
                print("Fail to get notification")
            }
        }
    }
    //-----------------------------------------
    private func setupSearchBar() {
          definesPresentationContext = true
          navigationItem.searchController = self.searchController
          navigationItem.hidesSearchBarWhenScrolling = false
          searchController.searchBar.delegate = self
          let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
          textFieldInsideSearchBar?.placeholder = "Tìm kiếm"
      }
    //-----------------------------------------
    func checkState(state: String,
                    cell: CustomCollectionViewCell) {
        if state == "seen_and_read" {
            cell.backgroundColor = UIColor(rgb: 0xFFFFFF)
        } else {
            cell.backgroundColor = UIColor(rgb: 0xECF7E7)
        }
    }
    //-----------------------------------------
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        if searchText != "" {
            searchResults = notifications.filter{ $0.message.text.lowercased().contains(searchText.lowercased())
            }
            collectionView.reloadData()
        } else {
            searchResults = notifications
            collectionView.reloadData()
        }
    }
}
//-----------------------------------------
extension NotificationCollectionController: UICollectionViewDelegate,
                                            UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : notifications.count
    }
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell",
                                                    for: indexPath) as? CustomCollectionViewCell {
            var datas = notifications[indexPath.row]
            if searchController.isActive {
                datas = searchResults[indexPath.row]
            } else {
                datas = notifications[indexPath.row]
            }
            cell.configureCollectionViewCell(semiboldText: datas.subjectName,
                           normalText: datas.message.text,
                           date: createDateTime(timestamp: String(datas.createdAt)),
                           avatarURL: datas.image,
                           iconURL: datas.icon)
            checkState(state: datas.status.rawValue,
                       cell: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if notifications[indexPath.row].status.rawValue == "seen_but_unread" {
            notifications[indexPath.row].status = .seenAndRead
            collectionView.reloadItems(at: [indexPath])
        } else {
            collectionView.reloadItems(at: [indexPath])
        }
    }
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = UIScreen.main.bounds.width
            return CGSize(width: screenWidth, height: 80)
    }
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    //-----------------------------------------
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
}
