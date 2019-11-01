//
//  AddViewController.swift
//  wordcase_dictionary_test
//
//  Created by 新谷修平 on 2019/10/31.
//  Copyright © 2019 Shuhei Shintani. All rights reserved.
//

import UIKit

protocol CatchProtocol {
    func catchData(contentDictionary: Dictionary<Int, String>, referenceDictionary: Dictionary<Int, String>)
}

var contentDictionary: [Int:String] = [:]
var referenceDictionary: [Int:String] = [:]


class AddViewController: UIViewController, UITextFieldDelegate {
    
    var content = String()
    var reference = String()
    var contentCount = 0
    var referenceCount = 0
    var delegate: CatchProtocol?

    @IBOutlet weak var contentPreview: UILabel!
    
    @IBOutlet weak var referencePreview: UILabel!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var referenceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextField.delegate = self
        referenceTextField.delegate = self
        
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        content = contentTextField.text!
        reference = referenceTextField.text!
        contentCount += 1
        referenceCount += 1
        contentDictionary.updateValue(content, forKey: contentCount)
        referenceDictionary.updateValue(reference, forKey: referenceCount)
        contentTextField.text = ""
        referenceTextField.text = ""
    }
    
    @IBAction func addPreviewButton(_ sender: Any) {
        content = contentTextField.text!
        reference = referenceTextField.text!
        contentPreview.text = content
        referencePreview.text = "──  \(reference)"
    }
    
    @IBAction func backButton(_ sender: Any) {
        delegate?.catchData(contentDictionary: contentDictionary, referenceDictionary: referenceDictionary)
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextField.resignFirstResponder()
        referenceTextField.resignFirstResponder()
        return true
    }
    
   

}
