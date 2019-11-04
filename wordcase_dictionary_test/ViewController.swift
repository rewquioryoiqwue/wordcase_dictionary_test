//
//  ViewController.swift
//  wordcase_dictionary_test
//
//  Created by 新谷修平 on 2019/10/31.
//  Copyright © 2019 Shuhei Shintani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CatchProtocol {
    
    func catchData(contentDictionary: Dictionary<Int, String>, referenceDictionary: Dictionary<Int, String>) {
        viewedContentDictionary = contentDictionary
        viewedReferenceDictionary = referenceDictionary
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewedContentDictionary = [Int:String]()
    var viewedReferenceDictionary = [Int:String]()
    var contentArray = [String]()
    var referenceArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if UserDefaults.standard.object(forKey: "contentDictionary") != nil {
            viewedContentDictionary = UserDefaults.standard.object(forKey: "contentDictionary") as! [Int : String]
        }
        
        if UserDefaults.standard.object(forKey: "referenceDictionary") != nil {
            viewedReferenceDictionary = UserDefaults.standard.object(forKey: "referenceDictionary") as! [Int : String]
        }


    }

    override func viewWillAppear(_ animated: Bool) {
        if addAfterCount > addBeforeCount {
            for i in 1...contentDictionary.count {
                contentArray.append(viewedContentDictionary[i]!)
                referenceArray.append(viewedReferenceDictionary[i]!)
                tableView.reloadData()
            }
            addBeforeCount = 0
            addAfterCount = 0
        }
    }
    
    @IBAction func transAddButton(_ sender: Any) {
        performSegue(withIdentifier: "transAdd", sender: nil)
    }
        
    @IBAction func transScreenButton(_ sender: Any) {
        performSegue(withIdentifier: "transScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "transAdd" {
            let addVC = segue.destination as! AddViewController
            addVC.delegate = self
        }
        
        if segue.identifier == "transScreen" {
            let screenVC = segue.destination as! ScreenViewController

            screenVC.screenContentDictionary = contentDictionary
            screenVC.screenReferenceDictionary = referenceDictionary
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = "\(contentArray[indexPath.row])(\(referenceArray[indexPath.row]))"
        cell.textLabel?.numberOfLines=0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/6
    }
    
}

