//
//  AddViewController.swift
//  taskHub
//
//  Created by Anton on 18.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class AddViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var coment: UITextField!
    @IBOutlet var hed: UITextField!
    private let defaults = UserDefaults.init(suiteName: "group.myHub")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hed.delegate = self
        coment.delegate = self
        
        view.addTapGestureToHideKeyboard()
    }

    @IBAction func ready(_ sender: Any) {
        save()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentShortDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .full
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hed.resignFirstResponder()
        coment.resignFirstResponder()
        save()
        return true
    }
    
    func save(){
        if (hed.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            alert(message: "Имя не должно быть пустым!", on: self)
        }else{
            Defaults[.arrayHed].append(hed.text!)
            Defaults[.arrayComent].append(coment.text!)
            defaults?.set("Новая", forKey: "status"+(hed.text!))
            Defaults[.arrayDate].append(getCurrentShortDate())
            navigationController?.popViewController(animated: true)
            defaults?.synchronize()
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DefaultsKeys {
    static let arrayHed = DefaultsKey<[String]>("arrayHed")
    static let arrayComent = DefaultsKey<[String]>("arrayComent")
    static let arrayDate = DefaultsKey<[String]>("arrayDate")
    
    static let indexStat = DefaultsKey<String>("indexStat")
    static let index = DefaultsKey<Int>("index")
    static let filter = DefaultsKey<String>("filter")

}
