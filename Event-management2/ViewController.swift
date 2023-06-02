//
//  ViewController.swift
//  Event-management2
//
//  Created by Akanksha Pakhale on 28/05/23.
//

import UIKit
//MARK: - global variable declaration
var empList = [Employees]()
var sortedAdatalist: [Employees] = [Employees]()
var sortedBdatalist: [Employees] = [Employees]()



class ViewController: UIViewController {
//MARK: - IBoutlets on ViewController
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var mysearchbar: UISearchBar!
    
   
    
    
//MARK: - variable declaration
    var empList: [Employees] = [Employees]()
    var sortedAdatalist: [Employees] = [Employees]()
    var sortedBdatalist: [Employees] = [Employees]()
    var starlist = [String]()
    var ele = ""
    
   // var sortedempList = [Any]()
    
    var searchdata: [Employees] = [Employees]()
    var searching = false
    
    var favEmp = [Int:Bool]()
    
    var peoplelist = [Employees]()
    var searchedpeoplelist = [Employees]()
    
    var newsort: [Employees] = [Employees]()
//MARK: - Main method
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        //fetchlocaldata()
       fetchapidata()
       
    }
//MARK: -  IBACtion outlets
    //Button Open Favourite List
    @IBAction func openFav(_ sender: Any) {
        let favHome = self.storyboard?.instantiateViewController(withIdentifier: "FavViewController") as! FavViewController
        favHome.updatedlist = starlist
        self.navigationController?.pushViewController(favHome, animated: true)
    }
    //Continue to next page
    @IBAction func Continue(_ sender: Any) {
//        let vc:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        print("No action")
    }
    //Button to open sorted by ID list
    @IBAction func openAsorted(_ sender: Any) {
                let vc:SortedAViewController = self.storyboard?.instantiateViewController(withIdentifier: "SortedAViewController") as! SortedAViewController
                   vc.peoplelist = peoplelist
                self.navigationController?.pushViewController(vc, animated: true)
    }
    //Button to open category sorted by list
    @IBAction func openBsorted(_ sender: Any) {
                let vc:SortedBViewController = self.storyboard?.instantiateViewController(withIdentifier: "SortedBViewController") as! SortedBViewController
        vc.peoplelist = peoplelist
                self.navigationController?.pushViewController(vc, animated: true)
      //  print("No action")
    }
//MARK: - API call
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
                    let receivedapiData = try JSONDecoder().decode([Employees].self, from: data)
                    self.peoplelist = receivedapiData
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


//MARK: - Extension Required
//tableView extension
extension ViewController:UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    //api count
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searching == false {
                return peoplelist.count
            }
            else{
                //return search data
                return searchedpeoplelist.count
            }
    
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        if searching == false {
            let urlImage = URL(string: peoplelist[indexPath.row].image)
            cell.myimage.downloadingImage(from: urlImage!)
            cell.lbltitle.text = peoplelist[indexPath.row].name
            cell.lblsubtitle.text = peoplelist[indexPath.row].description
            cell.lblcategory.text = peoplelist[indexPath.row].category
            
        } else if searching == true  {
        //search Functionality data
            let urlImage = URL(string: searchedpeoplelist[indexPath.row].image)
            cell.myimage.downloadingImage(from: urlImage!)
        cell.lbltitle.text = searchedpeoplelist[indexPath.row].name
        cell.lblsubtitle.text = searchedpeoplelist[indexPath.row].description
            cell.lblcategory.text = searchedpeoplelist[indexPath.row].category
           
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.name = peoplelist[indexPath.row].name
        vc?.about = peoplelist[indexPath.row].description
        vc?.ctc = peoplelist[indexPath.row].ctc
        vc?.exp = peoplelist[indexPath.row].exp
        vc?.link = peoplelist[indexPath.row].link
        vc?.imagelink = peoplelist[indexPath.row].image
        vc?.favlist = starlist
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addfav = UIContextualAction(style: .normal, title: "Add favourite "){ [self] _, _, _ in
            //check fav list
            var name = String(peoplelist[indexPath.row].name)
            if starlist.contains(name) {
                //show else
                let alertController = UIAlertController(title: "Alert", message: "Already exist in favourites list", preferredStyle: .alert)
                      
                      // Add an action to the alert
                      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                      alertController.addAction(okAction)
                      
                      // Present the alert
                      present(alertController, animated: true, completion: nil)
                  }
            else {
            self.ele = peoplelist[indexPath.row].name
            starlist.append(ele)
            print("added")
            print(starlist)
                let alertController = UIAlertController(title: "Message", message: "Added favourites list", preferredStyle: .alert)
                      
                      // Add an action to the alert
                      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                      alertController.addAction(okAction)
                      
                      // Present the alert
                      present(alertController, animated: true, completion: nil)
                
            }
           
        }
        let removefav = UIContextualAction(style: .normal, title: "remove favourite "){ [self] _, _, _ in
             var name = String(peoplelist[indexPath.row].name)
            if starlist.contains(name){
                starlist.remove(at: indexPath.row)
                print(starlist)
                let alertController = UIAlertController(title: "Message", message: "Removed from favourites", preferredStyle: .alert)
                      
                      // Add an action to the alert
                      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                      alertController.addAction(okAction)
                      
                      // Present the alert
                      present(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Alert", message: "Non availaible in favourites list", preferredStyle: .alert)
                      
                      // Add an action to the alert
                      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                      alertController.addAction(okAction)
                      
                      // Present the alert
                      present(alertController, animated: true, completion: nil)
            }
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [addfav,removefav])
        return swipeConfiguration
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    private func  scrollToTop(){
        let topRow = IndexPath(row: 0, section: 0)
        tblView.scrollToRow(at: topRow, at: .top, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        searchedpeoplelist = []
        tblView.scrollsToTop = true
        for emp in peoplelist {
            if mysearchbar.text == ""
            {
                searchedpeoplelist = peoplelist
            }
            else {
                if emp.name.lowercased().contains(mysearchbar.text!.lowercased()) || emp.category.lowercased().contains(mysearchbar.text!.lowercased()){
                    searchedpeoplelist.append(emp)
                }
            }
        }
        tblView.reloadData()
        if searchedpeoplelist.count>0 {
            scrollToTop()
        }
    }
}
//Downloading APi image extension
extension UIImageView{
    func downloadingImage(from url:URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType?.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}
extension ViewController: PassFavData{
    func passData(str: [String]) {
        starlist = str
    }
}
