//
//  ViewController.swift
//  HelloWorld
//
//  Created by Tomer Buzaglo on 09/03/2016.
//  Copyright © 2016 Tomer Buzaglo. All rights reserved.
//

import UIKit

enum Phone: CustomStringConvertible{
    case Home(String)
    case Office(String)
    case Mobile(String)
    
    var description:String{
        switch self{
        case .Mobile(let number):
            return "Mobile: \(number)"
        case .Office(let number):
            return "Office: \(number)"
        case .Home(let number):
            return "Home: \(number)"
        }
    }
    init?(rawValue: Int, number:String) {
        // Check if string contains 'carrousel'
        switch rawValue{
        case 0:
            self = .Home(number)
        case 1:
            self = .Office(number)
        case 2:
            self = .Mobile(number)
        default:
            return nil
        }
    }
}

class ViewController: UIViewController {
    var arr = [Phone]()
    
    @IBAction func saveBtn(sender: UIButton) {
        
        
        if let number = phoneText.text,
            let _ = phoneType.titleForSegmentAtIndex(phoneType.selectedSegmentIndex) where phoneType.selectedSegmentIndex >= 0 && phoneType.selectedSegmentIndex <= 2{
                arr.append(Phone(rawValue: phoneType.selectedSegmentIndex, number:number)!)
                phoneText.text = ""
        }
        for n in arr{
            print(n)
        }
    }
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var phoneType: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

