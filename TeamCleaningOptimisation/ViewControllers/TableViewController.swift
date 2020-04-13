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
    // Segmented control
    @IBOutlet weak var scFloorSelection: UISegmentedControl!
    var rooms: Rooms?
    
    
    // Lifecycle methods
    override func viewDidLoad() {
        let apiRequest = APIRequest()
        do {
           try apiRequest.getRooms(completion: { result in
                switch result {
                case .success(let rooms) :
                    self.rooms = rooms
                    print(rooms)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                print(rooms.count)
                case .failure(let error) : print(error)
                }})
        
          } catch {
              print("Error getting data from API")
          }
        super.viewDidLoad()
        tableView.dataSource = self
        self.title = "Room List"
    }
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let segmentIndex = scFloorSelection.selectedSegmentIndex
        let roomsInThisFloor = roomsToFloors(floorNumber: segmentIndex)
        
        return roomsInThisFloor.count
    }
    
    func roomsToFloors(floorNumber: Int) -> Array<Room> {
        var returnArray: [Room] = []
        guard let roomsUnwrapped = rooms else {
            print("Rooms array was nil")
            return returnArray
        }
        for room in roomsUnwrapped {
            if (Int(room.floorId) == (floorNumber+1)) {
                returnArray.append(room)
            }
        }
        return returnArray
    }
    
    //Define cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        let room = rooms?[indexPath.row]
        cell.updateContent(roomID: room?.roomID ?? "0", roomIndex: room?.dirtIndex ?? 0)
        /*
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
 */
        
        return cell
    }
    
    // didSelectRowAt
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowInfo", sender: indexPath.row)
        print(indexPath.row)
        
       }
    
    //prepare function to pass data between two ViewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ShowInfo") {
        
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destViewController = segue.destination as? RoomInfoViewController else {return}
                let selectedRow = indexPath.row
                destViewController.room = rooms?[selectedRow]
                /*
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
                         } */
            }
        }
    }
    
    @IBAction func scSelectFloor(_ sender: UISegmentedControl) {
       // let getIndex = scFloorSelection.selectedSegmentIndex
        //print(getIndex)
        tableView.reloadData()
    }
}
