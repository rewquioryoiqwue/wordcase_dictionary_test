//
//  ScreenViewController.swift
//  wordcase_dictionary_test
//
//  Created by 新谷修平 on 2019/11/01.
//  Copyright © 2019 Shuhei Shintani. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {
    
    var screenContentDictionary = [Int:String]()
    var screenReferenceDictionary = [Int:String]()
    var i = 1
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var referenceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.text = screenContentDictionary[i]
        referenceLabel.text = "──  \(screenReferenceDictionary[i]!)"
        
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.minimumScaleFactor = 0.8
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        if i < screenContentDictionary.count {
            i += 1
            contentLabel.text = screenContentDictionary[i]
            referenceLabel.text = "──  \(screenReferenceDictionary[i]!)"
        } else {
            i = 1
            contentLabel.text = screenContentDictionary[i]
            referenceLabel.text = "──  \(screenReferenceDictionary[i]!)"
        }
    }
    
    @IBAction func previousButton(_ sender: Any) {
        if i > 1 {
            i -= 1
            contentLabel.text = screenContentDictionary[i]
            referenceLabel.text = "──  \(screenReferenceDictionary[i]!)"
        } else {
            i = screenContentDictionary.count
            contentLabel.text = screenContentDictionary[i]
            referenceLabel.text = "──  \(screenReferenceDictionary[i]!)"
        }
    }
    
}
