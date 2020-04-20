//
//  SelectionViewController.swift
//  TeamCleaningOptimisation
//
//  Created by Artur Kulagin on 16.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    
    @IBOutlet weak var bDropDownBtn: RoundButton!
    @IBOutlet weak var bTblView: UITableView!
    
    @IBOutlet weak var fDropDownBtn: RoundButton!
    @IBOutlet weak var fTblView: UITableView!
    
    @IBOutlet weak var aDropDownBtn: RoundButton!
    @IBOutlet weak var aTblView: UITableView!
    
    var selectedBuilding = 0
    var selectedFloor = 0
    var selectedArea = 0
    
    var buildingList = ["Building1", "Building2"]
    var floorList = ["Floor1", "Floor2"]
    var areaList = ["Area1", "Area2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bTblView.delegate = self
        fTblView.delegate = self
        aTblView.delegate = self
        
        bTblView.dataSource = self
        fTblView.dataSource = self
        aTblView.dataSource = self
        
        bTblView.isHidden = true
        fTblView.isHidden = true
        aTblView.isHidden = true
    }
    
    
    @IBAction func onClickdropDownBBtn(_ sender: Any) {
        if bTblView.isHidden {
            animate(toogle: true, btn: self.bTblView)
        } else {
            animate(toogle: false, btn: self.bTblView)
        }
    }
    
    @IBAction func onClickdropDownFBtn(_ sender: Any) {
        if fTblView.isHidden {
            animate(toogle: true, btn: self.fTblView)
        } else {
            animate(toogle: false, btn: self.fTblView)
        }
    }
    
    @IBAction func onClickdropDownABtn(_ sender: Any) {
        if aTblView.isHidden {
            animate(toogle: true, btn: self.aTblView)
        } else {
            animate(toogle: false, btn: self.aTblView)
        }
    }
    
    func animate(toogle: Bool, btn: UITableView){
        if toogle {
            UIView.animate(withDuration: 0.3) {
                btn.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                btn.isHidden = true
            }
        }
        
    }
}

// Extension to use tableView
extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRow = 1
        
        switch tableView {
        case bTblView:
            numberOfRow = buildingList.count
        case fTblView:
            numberOfRow = floorList.count
        case aTblView:
            numberOfRow = areaList.count
        default:
            print("Something Wrong!")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        // Add right content to right tabelView
        switch tableView {
        case bTblView:
            cell = tableView.dequeueReusableCell(withIdentifier: "bCell", for: indexPath)
            cell.textLabel?.text = buildingList[indexPath.row]
            
        case fTblView:
            cell = tableView.dequeueReusableCell(withIdentifier: "fCell", for: indexPath)
            cell.textLabel?.text = floorList[indexPath.row]
            
        case aTblView:
            cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath)
            cell.textLabel?.text = areaList[indexPath.row]
        default:
            print("Something Wrong!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case bTblView:
            bDropDownBtn.setTitle(buildingList[indexPath.row], for: .normal)
            animate(toogle: false, btn: self.bTblView)
            selectedBuilding = indexPath.row
            print(selectedBuilding)
            
        case fTblView:
            fDropDownBtn.setTitle(floorList[indexPath.row], for: .normal)
            animate(toogle: false, btn: self.fTblView)
            selectedFloor = indexPath.row
            print(selectedFloor)
            
        case aTblView:
            aDropDownBtn.setTitle(areaList[indexPath.row], for: .normal)
            animate(toogle: false, btn: self.aTblView)
            selectedArea = indexPath.row
            print(selectedArea)
            
        default:
            print("Something Wrong!")
        }
    }
}
