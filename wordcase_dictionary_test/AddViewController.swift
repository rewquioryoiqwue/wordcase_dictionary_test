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
var addBeforeCount = 0
var addAfterCount = 0


class AddViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var content = String()
    var reference = String()
    var contentCount = 0
    var referenceCount = 0
    var delegate: CatchProtocol?
    var scrollView = UIScrollView()
    

    @IBOutlet weak var contentPreview: UILabel!
    
    @IBOutlet weak var referencePreview: UILabel!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var referenceTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextField.delegate = self
        referenceTextField.delegate = self
        
        self.scrollView.delegate = self
        self.scrollView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.scrollView.addSubview(self.contentTextField)
        self.scrollView.addSubview(self.referenceTextField)
        self.scrollView.addSubview(self.addButton)
        self.scrollView.addSubview(self.backButton)
        self.view.addSubview(self.scrollView)
        
        addBeforeCount = contentDictionary.count
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.configureObserver()
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        if contentTextField.text != "" {
            content = contentTextField.text!
            reference = referenceTextField.text!
            contentCount += 1
            referenceCount += 1
            contentDictionary.updateValue(content, forKey: contentCount)
            referenceDictionary.updateValue(reference, forKey: referenceCount)
            contentTextField.text = ""
            referenceTextField.text = ""
            contentPreview.text = ""
            referencePreview.text = ""
            addAfterCount = addBeforeCount + 1
        } else {
            return
        }
        
        UserDefaults.standard.set(contentDictionary, forKey: "contentDictionary" )
        UserDefaults.standard.set(referenceDictionary, forKey: "referenceDictionary" )

    }
    
    @IBAction func backButton(_ sender: Any) {
        delegate?.catchData(contentDictionary: contentDictionary, referenceDictionary: referenceDictionary)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextField.resignFirstResponder()
        referenceTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == contentTextField {
            let contentTmpStr = contentTextField.text! as NSString
            let contentReplacedString = contentTmpStr.replacingCharacters(in: range, with: string)
            contentPreview.text = contentReplacedString
            contentPreview.adjustsFontSizeToFitWidth = true
            contentPreview.minimumScaleFactor = 0.8
        }
        
        if textField == referenceTextField {
            let referenceTmpStr = referenceTextField.text! as NSString
            let referenceReplacedString = referenceTmpStr.replacingCharacters(in: range, with: string)
            referencePreview.text = "──  \(referenceReplacedString)"
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if textField == contentTextField {
            contentPreview.text = ""
        }
        
        if textField == referenceTextField {
            referencePreview.text = ""
        }
        
        return true
    }
    
    func configureObserver() {
          
      let notification = NotificationCenter.default

      notification.addObserver(
        self,
        selector: #selector(self.keyboardWillShow(notification:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil
      )
          
      notification.addObserver(
        self,
        selector: #selector(self.keyboardWillHide(notification:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil
      )
    }
    
    // Notificationを削除
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // キーボードが現れたときにviewをずらす
    @objc func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
        }
    }
    
    // キーボードが消えたときにviewを戻す
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform.identity
        }
    }

}
