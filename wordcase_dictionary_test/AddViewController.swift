//
//  AddViewController.swift
//  wordcase_dictionary_test
//
//  Created by 新谷修平 on 2019/10/31.
//  Copyright © 2019 Shuhei Shintani. All rights reserved.
//

import UIKit

protocol CatchProtocol {
    func catchData(wordDictionary: Dictionary<String, String>)
}

var wordDictionary: [String: String] = [:]


class AddViewController: UIViewController, UITextFieldDelegate {
    
    var content = String()
    var referrence = String()
    var delegate: CatchProtocol?

    @IBOutlet weak var contentPreview: UILabel!
    
    @IBOutlet weak var referrencePreview: UILabel!
    
    
    
    @IBOutlet weak var contentTextField: UITextField!
    
    
    @IBOutlet weak var referrenceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextField.delegate = self
        referrenceTextField.delegate = self
        
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        content = contentTextField.text!
        referrence = referrenceTextField.text!
        wordDictionary.updateValue(referrence, forKey: content)
        contentTextField.text = ""
        referrenceTextField.text = ""
    }
    
    @IBAction func addPreviewButton(_ sender: Any) {
        content = contentTextField.text!
        referrence = referrenceTextField.text!
        contentPreview.text = content
        referrencePreview.text = "──  \(referrence)"
        
//        contentPreview.text = Array(wordDictionary.keys).last
//        referrencePreview.text = wordDictionary[content]
               
    }
    
    @IBAction func backButton(_ sender: Any) {
        delegate?.catchData(wordDictionary: wordDictionary)
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextField.resignFirstResponder()
        referrenceTextField.resignFirstResponder()
        return true
    }
    
   

}
