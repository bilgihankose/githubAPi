//
//  ViewController.swift
//  githubAPI
//
//  Created by Bilgihan Köse on 7.05.2020.
//  Copyright © 2020 Bilgihan Kose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var urlLabel: UILabel!
    
    
    @IBOutlet weak var companyLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func gonderButton(_ sender: UIButton) {
        
        //API'yla calisirken sirasiyla aslinda uc temel yok var bunlar:
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        
        //1.
        let url = URL(string: "https://api.github.com/users/bilgihankose")
        
        
        let session = URLSession.shared
        
        //Closure
        
        let task = session.dataTask(with: url!) { (data, res, error) in
            if error != nil {
                let alert = UIAlertController(title: "Eror", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert , animated: true, completion: nil)
                
            } else {
                if data != nil {
                    
                    do {
                        let jsonResponse = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> //Bunu verileri dictonary'ye cevirmek icin yaptik (as! kismini)
                        
                        //ASYNC
                        
                        DispatchQueue.main.async() {
                            
                            if let name = jsonResponse["name"] {
                                self.nameLabel.text = "Name :\(name)"
                            }
                            
                            if let userUrl = jsonResponse["url"] {
                                                           self.urlLabel.text = "URL :\(userUrl)"
                                                       }
                            
                            if let company = jsonResponse["company"] {
                                                           self.companyLabel.text = "Company :\(company)"
                                                       }
                            
                            if let location = jsonResponse["location"] {
                                                           self.locationLabel.text = "Location :\(location)"
                                                       }
                            
                            
                                
                        }
                        
                        
                        
                    } catch {
                        print("error")
                    }
                   
                    
                }
            }
            
            
            
        }
        task.resume()
        
    }
    
    
    
    
}

