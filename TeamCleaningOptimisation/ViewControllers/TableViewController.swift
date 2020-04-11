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
    var floor1_sorted = [RoomIndex]()
    var floor2_sorted = [RoomIndex]()
    var floor3_sorted = [RoomIndex]()

    let sampleIndexes = [75, 80, 29, 66, 97, 40, 30, 99]
    let sampleTime = ["3h","4h","2h","1h"]
    @IBOutlet weak var scFloorSelection: UISegmentedControl!
    
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.title = "Room List"
        loadSampleDataFloor()
        
        // Get json data from db
        //let apiRequest = APIRequest()
       // do {
           // try apiRequest.getRoom(roomID: "A100", completion:  (Result<Room,Error>)->Void)
       // }
        //catch {
         //   print("Error getting data from API")
        //}
        
    }
    
    // Protocol methods
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(scFloorSelection.selectedSegmentIndex)
        {
        case 0:
            returnValue = floor1_sorted.count
            break
        case 1:
            returnValue = floor2_sorted.count
            break
        case 2:
            returnValue = floor3_sorted.count
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
                cell.updateContent(with: floor1_sorted[indexPath.row].room, and: floor1_sorted[indexPath.row].index, and: floor1_sorted[indexPath.row].time)
            
                cell.viewWithTag(1)?.backgroundColor = floor1_sorted[indexPath.row].getColor(index: floor1_sorted[indexPath.row].index)
                cell.viewWithTag(2)?.backgroundColor = floor1_sorted[indexPath.row].getColor(index: floor1_sorted[indexPath.row].index)
                
                
                   break
               case 1:
                   cell.updateContent(with: floor2_sorted[indexPath.row].room, and: floor2_sorted[indexPath.row].index, and: floor2_sorted[indexPath.row].time)
                   
                   cell.viewWithTag(1)?.backgroundColor = floor2_sorted[indexPath.row].getColor(index: floor2_sorted[indexPath.row].index)
                   cell.viewWithTag(2)?.backgroundColor = floor2_sorted[indexPath.row].getColor(index: floor2_sorted[indexPath.row].index)
                   
                   break
               case 2:
                  cell.updateContent(with: floor3_sorted[indexPath.row].room, and: floor3_sorted[indexPath.row].index, and: floor3_sorted[indexPath.row].time)
                  
                  cell.viewWithTag(1)?.backgroundColor = floor3_sorted[indexPath.row].getColor(index: floor3_sorted[indexPath.row].index)
                  cell.viewWithTag(2)?.backgroundColor = floor3_sorted[indexPath.row].getColor(index: floor3_sorted[indexPath.row].index)
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
    
    //prepare function to pass data between two ViewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "ShowInfo"){
        
        if let indexPath = tableView.indexPathForSelectedRow {
         guard let destViewController = segue.destination as? RoomInfoViewController else {return}
        let selectedRow = indexPath.row
        switch(scFloorSelection.selectedSegmentIndex)
              {
              case 0:
                destViewController.getNumber = floor1_sorted[selectedRow].room
                  break
              case 1:
                destViewController.getNumber = floor2_sorted[selectedRow].room
                  break
              case 2:
                destViewController.getNumber = floor3_sorted[selectedRow].room
                  break
              default:
                  break
                 }
        
    }
         }
         }
    
    @IBAction func scSelectFloor(_ sender: UISegmentedControl) {
       // let getIndex = scFloorSelection.selectedSegmentIndex
        //print(getIndex)
        tableView.reloadData()
    }
    
    
    private func loadSampleDataFloor (){
        
        let room1_1 = RoomIndex(room: "A100", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room1_2 = RoomIndex(room: "A101", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room1_3 = RoomIndex(room: "A102", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room2_1 = RoomIndex(room: "A106", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room2_2 = RoomIndex(room: "A107", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_1 = RoomIndex(room: "311", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_2 = RoomIndex(room: "308", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_3 = RoomIndex(room: "326", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        let room3_4 = RoomIndex(room: "303", index: sampleIndexes.randomElement() ?? 0, time:sampleTime.randomElement() ?? "1h")
        
        floor1 += [room1_1, room1_2, room1_3]
        floor1_sorted = floor1.sorted(by: { $0.index < $1.index})
        floor2 += [room2_1, room2_2]
        floor2_sorted = floor2.sorted(by: { $0.index < $1.index })
        floor3 += [room3_1, room3_2, room3_3, room3_4]
        floor3_sorted = floor3.sorted(by: { $0.index < $1.index })
        
    }

}
