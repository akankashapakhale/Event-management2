//
//  SortedBViewController.swift
//  Event-management2
//
//  Created by Akanksha Pakhale on 30/05/23.
//

import UIKit

class SortedBViewController: UIViewController {
//MARK: - Variable declaration
    var sortedAdatalist: [Employees] = [Employees]()
    var sortedBdatalist: [Employees] = [Employees]()
    var empList: [Employees] = [Employees]()
    
    var peoplelist: [Employees] = [Employees]()
    
    var sortedList: [Employees] = [Employees]()
//MARK: - IBoutlets declaration
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchlocaldata()
        sortedList = peoplelist.sorted(by: { $0.category < $1.category })
    }
//MARK: - Function Declaration
    //fetching data function
    func fetchlocaldata(){
        guard let filelocation = Bundle.main.url(forResource: "Datanew", withExtension: "json")
        else {
            return
        }
        do {
            let data = try Data(contentsOf: filelocation)
            let receivedData = try JSONDecoder().decode([Employees].self, from: data)
            let sortedAdata = receivedData.filter { $0.category == "categoryA" }
            let sortedBdata = receivedData.filter { $0.category == "categoryB" }
            self.sortedAdatalist = sortedAdata
            //print(sortedAdatalist)
            self.sortedBdatalist = sortedBdata
            self.empList = receivedData
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
        catch {
            print("Error occured in decoding")
        }
    }
}
//MARK: - Extension
//tableview extension
extension SortedBViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellb", for: indexPath) as! SortBTableViewCell
        cell.lbltitle.text = sortedList[indexPath.row].name
        cell.lblsubtitle.text = "\(sortedList[indexPath.row].category)"
        return cell
    }
}
