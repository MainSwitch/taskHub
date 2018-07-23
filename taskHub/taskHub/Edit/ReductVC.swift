//
//  ReductVC.swift
//  taskHub
//
//  Created by Anton on 19.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ReductVC: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    
    @IBOutlet var hedName: UITextField!
    @IBOutlet var textTask: UITextView!
    private let defaults = UserDefaults(suiteName: "group.myHub")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hedName.delegate = self
        textTask.delegate = self
        //view.addTapGestureToHideKeyboard()
        
        let done = UIBarButtonItem(title: "Готово",
                                   style: .done,
                                   target: self,
                                   action: #selector(dismissView(sender:)))
        
        navigationItem.rightBarButtonItem = done
        if defaults?.bool(forKey: "isOpen") == true{
            hedName.text = Defaults[.arrayHed][(defaults?.integer(forKey: "coutForToday"))!]
            textTask.text = Defaults[.arrayComent][(defaults?.integer(forKey: "coutForToday"))!]
            defaults?.set(false, forKey: "isOpen")
        }else{
            hedName.text = Defaults[.arrayHed][Defaults[.index]]
            textTask.text = Defaults[.arrayComent][Defaults[.index]]
        }
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hedName.resignFirstResponder()
        return true
    }
    @objc func dismissView(sender: UIBarButtonItem){
        if (hedName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!{
            alert(message: "Поле не должно быть пустым", on: self)
        }
        if Defaults[.arrayHed][Defaults[.index]] != hedName.text && !(hedName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!  {
            Defaults[.arrayHed][Defaults[.index]] = hedName.text!
        }
        if Defaults[.arrayComent][Defaults[.index]] != textTask.text{
            Defaults[.arrayComent][Defaults[.index]] = textTask.text
        }
        defaults?.removeObject(forKey: "status" + (hedName.text)!)
        defaults?.set((defaults?.string(forKey:"choseStatus")), forKey: "status"+(hedName.text)!)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
extension UIView{
    func addTapGestureToHideKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        addGestureRecognizer(tapGesture)
    }
}
