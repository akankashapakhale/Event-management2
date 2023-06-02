//
//  SortedAViewController.swift
//  Event-management2
//
//  Created by Akanksha Pakhale on 29/05/23.
//

import UIKit

class SortedAViewController: UIViewController {
//MARK: - Variable declaration
    var sortedAdatalist: [Employees] = [Employees]()
    var sortedBdatalist: [Employees] = [Employees]()
    var empList: [Employees] = [Employees]()
    var peoplelist: [Employees] = [Employees]()
    
    var sortedList: [Employees] = [Employees]()
//MARK: - IBoutlets
    @IBOutlet weak var tblView: UITableView!
//MARK: - MAin
    override func viewDidLoad() {
        super.viewDidLoad()
        print(peoplelist)
        sortedList = peoplelist.sorted(by: { $0.id < $1.id })
        print(sortedList)
    }
//MARK: - Functions declaration
    func fetchapidata(){
        
    let url = URL(string:"https://akankashapakhale.github.io/apitest/DemoData.json")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error ) in
                guard let data = data, error == nil else
               {
                    print("Error occured while accessind data")
                    return
                }
                do {
                    self.peoplelist = try JSONDecoder().decode([Employees].self, from: data)
                }
                catch {
                    print("Error occured in decoding")
                }
                DispatchQueue.main.async {
                   // self.searchedpeoplelist = self.peoplelist
                    self.tblView.reloadData()
                }
            })
            task.resume()
    }
}
//MARK: - Extensions
//tableview extension
extension SortedAViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return sortedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as! SortATableViewCell
        cell.lbltitle.text = sortedList[indexPath.row].name
        cell.lblsubtitle.text = "\(sortedList[indexPath.row].id)"
        return cell
    }
    
    
}
