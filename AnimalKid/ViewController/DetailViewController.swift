//
//  DetailViewController.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/29/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , UITextViewDelegate{

    
    let topTextView = UITextView()
    
    @IBOutlet weak var titleBar: UILabel!
    
    @IBOutlet weak var imageBox: UIImageView!
    
    @IBOutlet weak var textBox: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var learnButton: UIButton!
    
    var animal:animalM?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(animal)
        titleBar.text = animal?.typeName ?? ""
       
        if (animal?.image == nil)
        {
            imageBox.image = UIImage(named: (animal?.imageName)!)
        }
        else
        {
           // imageBox.image = animal?.image
            imageBox.image = UIImage(data: animal?.image as! Data)
        }
        
        
        textBox.text = animal?.comment ?? ""
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("tst")
        
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        addAnotherTextView()
//        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    func addAnotherTextView()  {
        
        topTextView.delegate = self as! UITextViewDelegate
        topTextView.text = "Enter your notes here"
        topTextView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        topTextView.font = .systemFont(ofSize: 20)
        topTextView.becomeFirstResponder()
        
        view.addSubview(topTextView)
        topTextView.translatesAutoresizingMaskIntoConstraints = false
        [
            topTextView.topAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.topAnchor),
            topTextView.leadingAnchor.constraint(equalTo: view!.leadingAnchor),
            topTextView.trailingAnchor.constraint(equalTo: view!.trailingAnchor),
            topTextView.heightAnchor.constraint(equalToConstant: 40)
            ].forEach{
                $0.isActive = true
                
        }
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightGray
        
        if (textView.text == "Enter your notes here")
        {
            textView.text = ""
            textView.textColor = .black
        }
        
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
        
        if (textView.text == "")
        {
            textView.text = "Enter your notes here"
            textView.textColor = .lightGray
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            textBox.text = topTextView.text
            DBManager.shared.changeCommetByObject(animal: animal!, comment: textBox.text)
            topTextView.removeFromSuperview()
            
            return false
        }
        
        return true
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let approxSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach{(constraint) in
            
            if constraint.firstAttribute == .height
            {
                constraint.constant = approxSize.height
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Facts"
        {
            if let vc = segue.destination as? FactsViewController {
                vc.typeData = titleBar.text
            }
            
        }
    }

}
