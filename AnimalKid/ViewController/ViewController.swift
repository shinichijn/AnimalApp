//
//  ViewController.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/24/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON


class ViewController: UIViewController , UITableViewDelegate,UINavigationControllerDelegate, UITableViewDataSource, UITabBarControllerDelegate, UIImagePickerControllerDelegate, UISearchBarDelegate {

    
   // var animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
   // var animalData = Animals.fetchAnimal()
    
     let realm = try! Realm()
    var animalData: Results<animalM>?
    var backArray: Results<animalM>?
//    var animalData = [Animals]()
    
    var rawImage: UIImage?

    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let alertService = AlertService()
    
    var object:responseObject?
    
    let delegate = Alamofire.SessionManager.default.delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self;
        addDoneButtonOnKeyboard()
        loadRealmData()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        let swiftColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.3)
        searchBar.changeSearchBarColor(color: swiftColor)
        tableView.delegate = self
        tableView.dataSource = self
       // animalData.append(Animals(imageName: "dog1.jepg", typeName: "new dog", comment: "new dog"))
     
        delegate.taskWillPerformHTTPRedirection = { (_, _, _, _) -> URLRequest? in
            return nil
        }
        
        
      
        
        
        self.getTypeFromAPI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getTypeFromAPI()
    {
        let urlString = "http://0.0.0.0:5000/predict"
        let imageBase64 = "111"
        let parameters: Parameters = [
            "image":imageBase64
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        print(parameters)
        Alamofire.request(urlString, method: .post, parameters: parameters,encoding: URLEncoding.httpBody, headers: nil)
            .validate(statusCode: 200..<300)
            .responseString {
            response in
            print("res")
            print(response.result)
            switch response.result {
            case .success:
                self.object = JsonObject.shared.regcongitionResponse(data: response.data)
                print(response.response?.statusCode)
                print(response)
                print("Type is ")
                print(self.object!.typeName)
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
        
        
        
        
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        searchBar.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        searchBar.resignFirstResponder()
    }
    
    
    
    private func setupNavigationBarItem() {
        let barButtonItem = UIBarButtonItem(title: "Layout", style: .plain, target: self, action: #selector(layoutTapped(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    
    @objc private func layoutTapped(_ sender: Any) {
        
    }
    
    
    
    func setupKeyboard()
    {
        
        
        
    }
    
    
    func loadRealmData()
    {
        
        animalData = DBManager.shared.getAnimals()
        backArray = animalData
        
    }
   
    @IBAction func addImage(_ sender: Any) {
        
         let myActionSheet = UIAlertController(title: "Choose how you would like to take picture", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "CAMERA", style: .default) { (action) in
            
            self.takePicture()
                
                
            }
        
        
        let libary = UIAlertAction(title: "PHOTO LIBARY", style: .default) { (action) in
            
            
            self.takeLibary()
            
        }
        
        
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
        myActionSheet.addAction(camera)
        myActionSheet.addAction(libary)
        self.present(myActionSheet, animated: true, completion: nil)
        
        
    }
    
    
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            
             //var imgData: NSData = NSData(data: UIImageJPEGRepresentation(image, 0.5)!)
            self.rawImage = image
           
            self.dismiss(animated: true, completion: {
                let alertVC = self.alertService.alert(labelTitle: "Let's guess what's the kind this animal is", imageData: image){(animalM) -> Void in
                    DBManager.shared.addAnimal(animal: animalM)
                    self.tableView.reloadData()
                }
                self.present(alertVC, animated: true, completion: {
                    alertVC.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
                })
            })
        }
        
    }
    
    
    
    
    func takePicture()
    {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.sourceType = UIImagePickerControllerSourceType.camera
        
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
    
    
    func takeLibary()
    {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.tabBarController?.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let image = UIImage(named: "empty.jpeg")
        if animalData?.count == 0 {
            self.tableView.setEmptyView(title: "You don't have any animal photo yet.", message: "Hurry up!! Take some favorite photo!.", messageImage:image!)
        }
        else {
            self.tableView.restore()
        }
        
        return self.animalData!.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "aminialCell", for: indexPath) as! TableViewCell
        
        // set the text from the data model
        cell.animal = self.animalData![indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if (searchBar.text?.count != 0)
        {
            
            
            
            print("test for chang")
            let filter = searchBar.text! ?? ""
            //let aPredicate = NSPredicate(format: "comment CONTAINS" + " " + filter)
            print("so far so good")
            let aPredicate = NSPredicate(format: "comment CONTAINS[c] %@",  filter)
            animalData = { realm.objects(animalM.self).filter(aPredicate).sorted(byKeyPath: "created",ascending: false) }()
            self.view.endEditing(true)
            print(animalData)
            tableView.reloadData()
            
        }
        
        
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("test")
        if (searchBar.text?.count == 0)
        {
            //loadData()
            //            newArrary = backArrary
            //            tableView.reloadData()
            animalData = backArray
            tableView.reloadData()
        }
        else
        {
            //            notebookArray = notebookArray.filter ({$0.booking.range(of: searchBar.text!) != nil})
            //            tableView.reloadData()
            print("test for chang")
            let filter = searchBar.text! ?? ""
            //let aPredicate = NSPredicate(format: "comment CONTAINS" + " " + filter)
            print("so far so good")
            let aPredicate = NSPredicate(format: "comment CONTAINS[c] %@",  filter)
            animalData = { realm.objects(animalM.self).filter(aPredicate).sorted(byKeyPath: "created",ascending: false) }()
            //self.view.endEditing(true)
            print(animalData)
            tableView.reloadData()
        }
        
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailView" {
            
            if let selectIndexPath = self.tableView.indexPathForSelectedRow {
                
                let selectRow  = animalData![selectIndexPath.row]
                let VC = segue.destination as! DetailViewController
                VC.animal = selectRow
                
            }
        }
        
        
        
        
    }
    
    
    
    


}


extension UITableView {
    
    func setEmptyView(title: String, message: String,messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 25)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        
    }
    
}
extension UISearchBar {
    func changeSearchBarColor(color: UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                
                if let _ = subSubView as? UITextInputTraits {
                    let textField = subSubView as! UITextField
                    textField.backgroundColor = color
                    break
                }
                
            }
        }
    }
}


extension UISearchBar{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

