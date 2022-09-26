//
//  NotificationViewController.swift
//  Gapo-Login
//
//  Created by Dung on 9/13/22.
//

import UIKit
import Alamofire
import SDWebImage

class NotificationViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let tabBar = UITabBarController()
    var notifications = [DataItem]()
    var searchResults = [DataItem]()
    //------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotifications()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Thông báo"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
        setupSearchBar()
        searchResults = notifications
        self.tabBarItem.title = "Table"
    }
    //------------------------------------------
    func getNotifications() {
        let parameters: [String:Any] = [
            "limit": 20,
            "offset": 0
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
        request.responseDecodable(of: Notification.self) { [self] response in
            if response.response?.statusCode == 200 {
                self.notifications = response.value?.data ?? []
                self.tableView.reloadData()
            } else {
                print("Fail to get notification")
            }
        }
    }
    //------------------------------------------
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    //------------------------------------------
    private func setupSearchBar() {
          definesPresentationContext = true
          navigationItem.searchController = self.searchController
          navigationItem.hidesSearchBarWhenScrolling = false
          searchController.searchBar.delegate = self
          let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
          textFieldInsideSearchBar?.placeholder = "Tìm kiếm"
      }
    //------------------------------------------
    func checkState(state: String,
                    cell: CustomTableViewCell) {
        if state == "seen_and_read" {
            cell.backgroundColor = UIColor(rgb: 0xFFFFFF)
        } else {
            cell.backgroundColor = UIColor(rgb: 0xECF7E7)
        }
    }
    //------------------------------------------
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        if searchText != "" {
            searchResults = notifications.filter{ $0.message.text.lowercased().contains(searchText.lowercased())
            }
            tableView.reloadData()
        } else {
            searchResults = notifications
            tableView.reloadData()
        }
    }
}
//------------------------------------------
extension NotificationViewController : UITableViewDelegate,
                                        UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //----------------------------------------
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : notifications.count
    }
    //----------------------------------------
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell",
                                                    for: indexPath) as? CustomTableViewCell {
            var datas = notifications[indexPath.row]
            if searchController.isActive {
                datas = searchResults[indexPath.row]
            } else {
                datas = notifications[indexPath.row]
            }
            cell.configureTableViewCell(semiboldText: datas.subjectName,
                           normalText: datas.message.text,
                           date: createDateTime(timestamp: String(datas.createdAt)),
                           avatarURL: datas.image,
                           iconURL: datas.icon)
            checkState(state: datas.status.rawValue,
                       cell: cell)
            return cell
        }
        return UITableViewCell()
    }
    //----------------------------------------
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if notifications[indexPath.row].status.rawValue == "seen_but_unread" {
            notifications[indexPath.row].status = .seenAndRead
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    // Tableview cells automatically set height
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
