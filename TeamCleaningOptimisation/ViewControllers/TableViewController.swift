//
//  TableViewController.swift
//  TeamCleaningOptimization
//
//  Created by Oona on 25.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit
import Network

var selectedBuilding = 0
var selectedFloor = 0
var selectedArea = 0

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IB & variables
    
    @IBAction func onClickRefreshButton(_ sender: UIButton) {
        // Reload tableView in main thread
        DispatchQueue.main.async {
            self.doAPIRequest()
        }
    }
    @IBAction func onClickStatusReportButton(_ sender: UIButton) {
        let presentationService = StatusReportPresentationPresentationService()
        let presentation = presentationService.present()
        present(presentation, animated: true) {
            // Dismiss report if tapped outside
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissReport))
            presentation.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var selectionBuilding: UILabel!
    @IBOutlet weak var selectionFloor: UILabel!
    @IBOutlet weak var selectionArea: UILabel!
    
    var rooms: Rooms?
    let networkMonitor = NWPathMonitor()
    let connectionErrorTitle = "Connection error"
    let connectionErrorMessage = "No internet connection"
    let connectionErrorAction = "Ok"

    // Dismiss report if tapped
    @objc func dismissReport() {
        self.dismiss(animated: true)
    }
    
    // Lifecycle methods
    override func viewDidLoad() {
        doAPIRequest()
        super.viewDidLoad()
        tableView.dataSource = self
        self.title = "Room List"
        useNetworkMonitor()
    }
    
    private func useNetworkMonitor() {
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connected")
            } else {
                // Alert user
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: self.connectionErrorTitle, message: self.connectionErrorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: self.connectionErrorAction, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
        let queue = DispatchQueue(label: "networkMonitor")
        networkMonitor.start(queue: queue)
    }
    
    private func doAPIRequest() {
       let apiRequest = APIRequest()
        do {
           try apiRequest.getRooms(completion: { result in
                switch result {
                case .success(let rooms) :
                    self.rooms = rooms
                    // Reload tableView in main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error) : print(error)
                }})
        
          } catch {
              print("Error getting data from API")
          }
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
        
        for room in roomsInThisFloor {
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
            default:
                print("Index error")
            }
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
                destViewController.room = roomsInThisFloor[selectedRow]

            }
        }
    }
    @IBAction func unwindToTableViewController(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                // Display selection
                self.selectionBuilding.text = "Building: \(String(selectedBuilding + 1))"
                self.selectionFloor.text    = "Floor: \(String(selectedFloor + 1))"
                self.selectionArea.text     = "Area: \(String(selectedArea + 1))"
            }
        }
    }
}
