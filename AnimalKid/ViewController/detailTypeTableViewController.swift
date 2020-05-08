//
//  detailTypeTableViewController.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 3/4/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit
import RealmSwift


class detailTypeTableViewController: UITableViewController,UINavigationControllerDelegate{

    
    var typeData:animalCatgs?
//    var animalData = [Animals]()

    var animalData: Results<animalM>?
   // var animalData: Results<animalM>?
    
    let cellReuseIdentifier = "typeCell"
    
    @IBOutlet var tableview: UITableView!
    
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadRealmData()
        self.tableView.register(detailTypeCellTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableview.delegate = self
        tableview.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    
    func loadRealmData()
    {

        animalData = DBManager.shared.getAnimalsByType(type: typeData?.type)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let image = UIImage(named: "empty.jpeg")
        if animalData?.count == 0 {
            self.tableView.setEmptyView(title: "You don't have any \(typeData?.type ?? "") photo yet.", message: "Hurry up!! Take some favorite photo!.", messageImage:image!)
        }
        else {
            self.tableView.restore()
        }
        
        return animalData!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! detailTypeCellTableViewCell

        // set the text from the data model
        cell.animal = self.animalData![indexPath.row]
        return cell
    }
    
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoDetailView" {
            
            if let selectIndexPath = self.tableView.indexPathForSelectedRow {
                
                let selectRow  = animalData![selectIndexPath.row]
                let VC = segue.destination as! DetailViewController
                VC.animal = selectRow
                
            }
        }
        
        
        
        
    }
    
    
}


