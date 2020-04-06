//
//  TableViewController.swift
//  TeamCleaningOptimization
//
//  Created by Oona on 25.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IB & variables
    @IBOutlet var tableView: UITableView!
    
    var floor1 = [RoomIndex]()
    var floor2 = [RoomIndex]()
    var floor3 = [RoomIndex]()

    //let sampleDataFloor1 = [100, 105, 199]
   // let sampleDataFloor2 = [202, 233]
    //let sampleDataFloor3 = [301,304,305,306]
    let sampleIndexes = [29, 12, 66, 90, 40, 50]
    let sampleTime = ["3h","4h","2h","1h"]
    @IBOutlet weak var scFloorSelection: UISegmentedControl!
    
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.title = "Room List"
        loadSampleDataFloor()
    }
    
    // Protocol methods
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(scFloorSelection.selectedSegmentIndex)
        {
        case 0:
            returnValue = floor1.count
            break
        case 1:
            returnValue = floor2.count
            break
        case 2:
            returnValue = floor3.count
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
                cell.updateContent(with: floor1[indexPath.row].room, and: floor1[indexPath.row].index, and: floor1[indexPath.row].time)
            
                cell.viewWithTag(1)?.backgroundColor = floor1[indexPath.row].getColor(index: floor1[indexPath.row].index)
                cell.viewWithTag(2)?.backgroundColor = floor1[indexPath.row].getColor(index: floor1[indexPath.row].index)
                
                   break
               case 1:
                   cell.updateContent(with: floor2[indexPath.row].room, and: floor2[indexPath.row].index, and: floor2[indexPath.row].time)
                   
                   cell.viewWithTag(1)?.backgroundColor = floor2[indexPath.row].getColor(index: floor2[indexPath.row].index)
                   cell.viewWithTag(2)?.backgroundColor = floor2[indexPath.row].getColor(index: floor2[indexPath.row].index)
                   
                   break
               case 2:
                  cell.updateContent(with: floor3[indexPath.row].room, and: floor3[indexPath.row].index, and: floor3[indexPath.row].time)
                  
                  cell.viewWithTag(1)?.backgroundColor = floor3[indexPath.row].getColor(index: floor3[indexPath.row].index)
                  cell.viewWithTag(2)?.backgroundColor = floor3[indexPath.row].getColor(index: floor3[indexPath.row].index)
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
    
    //prepare function to pass data between two ViewControllers (use with performSegue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
         guard let destViewController = segue.destination as? RoomInfoViewController else {return}
        let selectedRow = indexPath.row
        switch(scFloorSelection.selectedSegmentIndex)
              {
              case 0:
                destViewController.getNumber = floor1[selectedRow].room
                  break
              case 1:
              
                destViewController.getNumber = floor2[selectedRow].room
                  break
              case 2:
                destViewController.getNumber = floor3[selectedRow].room
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
    
    
    private func loadSampleDataFloor (){
        
        let room1_1 = RoomIndex(room: "A101", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room1_2 = RoomIndex(room: "A105", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room1_3 = RoomIndex(room: "A117", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room2_1 = RoomIndex(room: "205", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room2_2 = RoomIndex(room: "210", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_1 = RoomIndex(room: "311", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_2 = RoomIndex(room: "308", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_3 = RoomIndex(room: "326", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_4 = RoomIndex(room: "303", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        
        floor1 += [room1_1, room1_2, room1_3]
        floor2 += [room2_1, room2_2]
        floor3 += [room3_1, room3_2, room3_3, room3_4]
        
        
        
    }

}
