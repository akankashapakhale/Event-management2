//
//  FavViewController.swift
//  Event-management2
//
//  Created by Akanksha Pakhale on 29/05/23.
//

import UIKit
protocol PassFavData {
    func passData(str:[String])
}

class FavViewController: UIViewController {
    var favdelegate: PassFavData!
    //MARK: - IBoutlets
    @IBOutlet weak var tblview: UITableView!
    //MARK: - variable declaration
    var updatedlist:[String]! = nil
    var favlist:[String]! = nil
    var ele = ""
    var removedfavlist:[String]! = nil
    //MARK: - MAin method
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.delegate = self
        tblview.dataSource = self
        print(updatedlist)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tblview.reloadData()
    }
}
//MARK: - Extensions
extension FavViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return 10
    return updatedlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblview.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = updatedlist[indexPath.row]
       // cell.textLabel?.text = "dhhffhhuuhuh"
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->
        UITableViewCell.EditingStyle {
            return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            updatedlist.remove(at: indexPath.row)
            //updatedlist = removedfavlist
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            tableView.reloadData()
            print(updatedlist)
        }
    }

}
