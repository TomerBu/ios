//
//  ViewController.swift
//  HelloWorld
//
//  Created by Tomer Buzaglo on 09/03/2016.
//  Copyright © 2016 Tomer Buzaglo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arr = [String]()
    
    @IBAction func saveBtn(sender: UIButton) {
        
        
        if let number = phoneText.text,
            let type = phoneType.titleForSegmentAtIndex(phoneType.selectedSegmentIndex){
                arr.append(type + number)
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

