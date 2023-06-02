//
//  DetailViewController.swift
//  Event-management2
//
//  Created by Akanksha Pakhale on 29/05/23.
//

import UIKit

protocol PassData {
    func passData(arr:[String])
}

class DetailViewController: UIViewController {
//MARK: - IBOutlets required
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var displayimg: UIImageView!
    
   
//MARK: - variable declaration
    var img = UIImageView()
    var name = ""
    var ctc = Int()
    var exp = Int()
    var about = ""
    var link = ""
    var imagelink = ""
    
    var favlist = [String]()
    var newvalue = ""
    var delegate:PassData!
    var data =  [String]()
    
//MARK: - MAIN
    override func viewDidLoad() {
        super.viewDidLoad()
        //assigning value to lable
        lbl1.text = "\(name)"
        lbl2.text = "\(ctc)"
        lbl3.text = "\(exp)"
        lbl4.text = "\(about)"
        let urlImage = URL(string:"\(imagelink)")
        displayimg.downloadingImage(from: urlImage!)
    }
//MARK: -  IBactions
    //Button actoin to open corresponding link to user
    @IBAction func openLink(_ sender: Any) {
        UIApplication.shared.open(URL(string: "\(link)")! as URL, options: [:], completionHandler: nil)
    }
  //Button Action to open other app to share profile
    @IBAction func shareButton(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["I am sharing this profile for your referenc"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true,completion: nil)
    }
    

    @IBAction func addfav(_ sender: Any) {
        print("No Action performed here")
    }
    @IBAction func openfav(_ sender: Any) {
        print("No Action performed here")
    }
}

