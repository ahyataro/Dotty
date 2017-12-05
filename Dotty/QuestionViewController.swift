//
//  QuestionViewController.swift
//  Dotty
//
//  Created by 中島清貴 on 2017/11/29.
//  Copyright © 2017年 kiyotaka.nakashima. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var cellText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = cellText!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
