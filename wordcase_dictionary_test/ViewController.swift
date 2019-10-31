//
//  ViewController.swift
//  wordcase_dictionary_test
//
//  Created by 新谷修平 on 2019/10/31.
//  Copyright © 2019 Shuhei Shintani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CatchProtocol {
    
    
    
    

    @IBOutlet weak var tableView: UITableView!

    var contentArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    @IBAction func transAddButton(_ sender: Any) {
        performSegue(withIdentifier: "transAdd", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addVC = segue.destination as! AddViewController
        addVC.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = contentArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/6
    }
    
    func catchData(wordDictionary: Dictionary<String, String>) {
        contentArray = Array(wordDictionary.keys)
        tableView.reloadData()
    }
    
    
}

