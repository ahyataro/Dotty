//
//  ViewController.swift
//  Dotty
//
//  Created by 中島清貴 on 2017/11/27.
//  Copyright © 2017年 kiyotaka.nakashima. All rights reserved.
//

import UIKit

let sectionTitle = ["タイトル1", "タイトル2"]
let section0 = [("キタハテ", "タテハチョウ科"), ("クロアゲハ", "アゲハチョウ科")]
let section1 = [("キタハテ2", "タテハチョウ科2"), ("クロアゲハ2", "アゲハチョウ科2")]
let tableData = [section0, section1]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCellText: String?
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myTableView = UITableView(frame: view.frame, style: .grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
        
        let url = URL(string: "https://dotty-api.herokuapp.com/questions")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])
                print(object)
            } catch let e {
                print(e)
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionData = tableData[indexPath.section]
        let cellData = sectionData[indexPath.row]
        selectedCellText = cellData.0
        
        if selectedCellText != nil {
            performSegue(withIdentifier: "toQuestionViewController", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toQuestionViewController") {
            let questionVC: QuestionViewController = (segue.destination as? QuestionViewController)!
            questionVC.cellText = selectedCellText
        }
    }
}

