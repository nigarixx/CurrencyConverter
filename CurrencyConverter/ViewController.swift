//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nigar Alaskarova on 25.05.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var aznLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        //1. Request & Session
        //2. Response & Data
        //3. Parsing & JSON Serialization
        
        //1. Request & Session
        let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_CYnMFhGaDqk9yPQbzFaydgUrpUTbb4OWkymJfCDw")
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                //2. Response & Data
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                            DispatchQueue.main.async {
//                                print(jsonResponse)
                               if let rates = jsonResponse["data"] as? [String : Any] {
                                    if let usd = rates["USD"] as? Int {
                                        self.usdLabel.text = "USD: \(usd)"
                                    }
                                    if let eur = rates["EUR"] as? Double {
                                       self.eurLabel.text = "EUR: \(eur)"
                                    }
                                   if let turkish = rates["TRY"] as? Double {
                                      self.tryLabel.text = "TRY: \(turkish)"
                                   }
                                   if let gbp = rates["GBP"] as? Double {
                                      self.gbpLabel.text = "GBP: \(gbp)"
                                   }
                                   if let jpy = rates["JPY"] as? Double {
                                      self.aznLabel.text = "JPY: \(jpy)"
                                   }
                                }
                            }
                    } catch {
                        print("Error")
                    }
                }
            }
        }
        task.resume()
    }
}
