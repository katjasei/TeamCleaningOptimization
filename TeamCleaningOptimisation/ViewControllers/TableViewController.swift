//
//  TableViewController.swift
//  TeamCleaningOptimization
//
//  Created by Oona on 25.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit
var selectedFloor = 0
class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Demo database
    
    var room1 = Room(floorId: "1", roomID: "A100", dirtIndex: 80, roomType: "Hospital Room")
    var room2 = Room(floorId: "1", roomID: "A101", dirtIndex: 33, roomType: "Hospital Room")
    var room3 = Room(floorId: "1", roomID: "A102", dirtIndex: 10, roomType: "Hospital Room")
    var room4 = Room(floorId: "1", roomID: "A103", dirtIndex: 56, roomType: "Hospital Room")
    var room5 = Room(floorId: "1", roomID: "A104", dirtIndex: 23, roomType: "Hospital Room")
    var room6 = Room(floorId: "1", roomID: "A105", dirtIndex: 99, roomType: "Hospital Room")

    var room7 = Room(floorId: "2", roomID: "A201", dirtIndex: 80, roomType: "Hospital Room")
    var room8 = Room(floorId: "2", roomID: "A202", dirtIndex: 40, roomType: "Hospital Room")
    var room9 = Room(floorId: "2", roomID: "A203", dirtIndex: 10, roomType: "Hospital Room")
    var room10 = Room(floorId: "2", roomID: "A204", dirtIndex: 97, roomType: "Hospital Room")
    var room11 = Room(floorId: "2", roomID: "A205", dirtIndex: 56, roomType: "Hospital Room")
    var room12 = Room(floorId: "2", roomID: "A206", dirtIndex: 44, roomType: "Hospital Room")
    var room13 = Room(floorId: "2", roomID: "A207", dirtIndex: 81, roomType: "Hospital Room")
    var room14 = Room(floorId: "2", roomID: "A208", dirtIndex: 80, roomType: "Hospital Room")
    
    var room15 = Room(floorId: "3", roomID: "A301", dirtIndex: 50, roomType: "Surgery")

    var rooms: Array<Room>!
    
    // MARK: IB & variables
    
    
    @IBOutlet var tableView: UITableView!
    
    // Dismiss report if tapped outside action
    @objc func dismissReport() {
        self.dismiss(animated: true)
    }

    
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // Init list of demo rooms
        rooms = [room1, room2, room3, room4, room5, room6, room7, room8, room9, room10, room11,
        room12, room13, room14]
        
        self.title = "Room List"
    }
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let roomsInThisFloor = roomsToFloors(floorNumber: selectedFloor)
        
        return roomsInThisFloor.count
    }
    
    // Picks rooms in selected floor and returns an array
    func roomsToFloors(floorNumber: Int) -> Array<Room> {
        var returnArray: [Room] = []
        guard let roomsUnwrapped = rooms else {
            print("Rooms array was nil")
            return returnArray
        }
        for room in roomsUnwrapped {
            if (Int(room.floorId) == (floorNumber + 1)) {
                returnArray.append(room)
            }
        }
        // Sort array
        returnArray.sort(by: {$0.dirtIndex > $1.dirtIndex})
        return returnArray
    }
    
    //Define cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell

        let roomsInThisFloor = roomsToFloors(floorNumber: selectedFloor)
        let room = roomsInThisFloor[indexPath.row]
        cell.updateContent(roomID: room.roomID, roomIndex: room.dirtIndex)
        
            switch room.dirtIndex {
                case 0...33:
                    let colour = UIColor(hex: "#81C784ff") ?? UIColor.white //green
                    cell.updateBackgroundColour(colour: colour)
                case 34...66:
                    let colour = UIColor(hex: "#FFF176ff") ?? UIColor.white //yellow
                    cell.updateBackgroundColour(colour: colour)
                case 67...90:
                    let colour = UIColor(hex: "#FFB74Dff") ?? UIColor.white // orange
                    cell.updateBackgroundColour(colour: colour)
                case 91...100:
                    let colour = UIColor(hex: "#EF5350ff") ?? UIColor.white //red
                    cell.updateBackgroundColour(colour: colour)
                    print("Cell coloured red")
            default:
                print("Index error")
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
        
        if (segue.identifier == "ShowInfo") {
        
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destViewController = segue.destination as? RoomInfoViewController else {return}

                let roomsInThisFloor = roomsToFloors(floorNumber: selectedFloor)
                let selectedRow = indexPath.row
                let roomType = roomsInThisFloor[indexPath.row].roomType
                destViewController.room = roomsInThisFloor[selectedRow]
                destViewController.roomType = roomType
            }
        }
    }
    @IBAction func unwindToTableViewController(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(selectedFloor)
            }
        }
    }
}
