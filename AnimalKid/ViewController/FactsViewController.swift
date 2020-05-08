//
//  FactsViewController.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 4/30/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit
import AVFoundation

class FactsViewController: UIViewController {

    
    var typeData:String?
    
    @IBOutlet weak var typeLable: UILabel!
    
    @IBOutlet weak var imagebox: UIImageView!
    
    @IBOutlet weak var readingButton: UIButton!
    
    @IBOutlet weak var factsBox: UITextView!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string:"")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeLable.text = typeData ?? ""
        if (typeData == "DOG")
        {
            imagebox.image = #imageLiteral(resourceName: "dog1")
            factsBox.text = """
            The dog is one of the most popular pets in the world (of course cat lovers will argue for cats). Dogs have long played an important role in the lives of humans. It's thought that dogs have been pets for thousands of years. Dogs are often called Man's Best Friend. This is because dogs help man out in so many ways.
            
            Types and Breeds of Dogs
            
            There are lots of breeds and types of dogs. Dogs vary in size from very small (just a couple of inches tall) to very large (three feet tall). Some breeds of dogs are considered better for indoor or outdoor pets and some breeds are considered working dogs. Jobs that dogs perform include hunting, police work, rescue work, and seeing-eye dogs for the blind. Because dogs are intelligent and willing to be trained, they make a great companion and work animal.
            
            Dogs are mammals. Different breeds have different characteristics and skills, but most dogs have large teeth, can run fast and jump, walk on their toes, and have strong muscles.
            """
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       
            synth.stopSpeaking(at: .immediate)
        
    }
    
    @IBAction func readingAction(_ sender: Any) {
        
        myUtterance = AVSpeechUtterance(string: factsBox.text)
        myUtterance.rate = 0.4
        synth.speak(myUtterance)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
