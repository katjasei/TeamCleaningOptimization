//
//  TableViewController.swift
//  TeamCleaningOptimization
//
//  Created by iosdev on 25.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // IB & variables
    @IBOutlet var tableView: UITableView!
    let sampleData = [100, 105, 199, 202, 233]
    let sampleIndexes = [29, 12, 66, 90]
    
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    // Protocol methods
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    //Define cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.updateContent(with: sampleData[indexPath.row], and: sampleIndexes.randomElement() ?? 0 )
        return cell
    }

}
