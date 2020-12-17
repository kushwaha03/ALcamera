//
//  TncViewController.swift
//  ALcamera
//
//  Created by Krishna Kushwaha on 16/12/20.
//

import UIKit

class TncViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var termsandconditions = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getJSON()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        getJSON()
         
    }
    
       func getJSON(){
        
           guard let gitUrl = URL(string: "https://debtest.flashntap.com/api/v1/terms") else { return }
           
           URLSession.shared.dataTask(with: gitUrl) { (data, response
               
               , error) in
               
               guard let data = data else { return }
               
               
               do {

                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                     // try to read out a string array
                                    if let data = json["data"] as? [String : Any] {
                                        if let termsandconditions = data["termsandconditions"] as? [[String:Any]] {
                                        self.termsandconditions = termsandconditions
                                        DispatchQueue.main.async {
                                        self.tableview.reloadData()
                                        }
                                        }
                                    }
                                    
                               
                                }
    
               } catch let err {
                   
                   print("Err", err)
                   
               }
               
           }.resume()
           
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return termsandconditions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TCTableViewCell
        cell.headerLbl.text = termsandconditions[indexPath.row]["h1"] as? String
        
        return cell

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
