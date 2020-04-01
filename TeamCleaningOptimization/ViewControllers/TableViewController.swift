//
//  TableViewController.swift
//  TeamCleaningOptimization
//
//  Created by Oona on 25.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // IB & variables
    @IBOutlet var tableView: UITableView!
    let sampleDataFloor1 = ["100", "105", "199"]
    let sampleDataFloor2 = ["202", "233"]
    let sampleDataFloor3 = ["301","304","305","306"]
    let sampleIndexes = [29, 12, 66, 90]
    @IBOutlet weak var scFloorSelection: UISegmentedControl!
    
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.title = "Room List"
       
       
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    // Protocol methods
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(scFloorSelection.selectedSegmentIndex)
        {
        case 0:
            returnValue = sampleDataFloor1.count
            break
        case 1:
            returnValue = sampleDataFloor2.count
            break
        case 2:
            returnValue = sampleDataFloor3.count
            break
        default:
            break
           }
        return returnValue
    }
    
    //Define cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        switch(scFloorSelection.selectedSegmentIndex)
               
               {
               case 0:
                     cell.updateContent(with: sampleDataFloor1[indexPath.row], and: sampleIndexes.randomElement() ?? 0 )
                   break
               case 1:
                   cell.updateContent(with: sampleDataFloor2[indexPath.row], and: sampleIndexes.randomElement() ?? 0 )
                   break
               case 2:
                  cell.updateContent(with: sampleDataFloor3[indexPath.row], and: sampleIndexes.randomElement() ?? 0 )
                   break
               default:
                   break
                  }
        
        return cell
    }
    
    // didSelectRowAt
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "ShowInfo", sender: indexPath.row)
        print(indexPath.row)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
         guard let destViewController = segue.destination as? RoomInfoViewController else {return}
        let selectedRow = indexPath.row
        switch(scFloorSelection.selectedSegmentIndex)
              {
              case 0:
                destViewController.getNumber = sampleDataFloor1[selectedRow]
                  break
              case 1:
              
                destViewController.getNumber = sampleDataFloor2[selectedRow]
                  break
              case 2:
                destViewController.getNumber = sampleDataFloor3[selectedRow]
                  break
              default:
                  break
                 }
    }
}
    
    @IBAction func scSelectFloor(_ sender: UISegmentedControl) {
       // let getIndex = scFloorSelection.selectedSegmentIndex
        //print(getIndex)
        tableView.reloadData()
    }

}
