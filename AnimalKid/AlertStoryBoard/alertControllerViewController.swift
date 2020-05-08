//
//  alertControllerViewController.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/28/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class alertControllerViewController: UIViewController {

    
    @IBOutlet weak var outerView: UIView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addbutton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var headerTitle: UILabel!
    
    var labelTitle:String?
    var imageData: NSData?
    var comment: String?
    let test:String = "1111"
    var buttonAtion: ((animalM) -> Void)?
    var object:responseObject?
    let delegate = Alamofire.SessionManager.default.delegate
    
    
    func imageToBase64(image: NSData) -> String
    {
        let base64 = image.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return base64
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate.taskWillPerformHTTPRedirection = { (_, _, _, _) -> URLRequest? in
            return nil
        }
        outerView.layer.cornerRadius = 10
        if (labelTitle != nil)
        {
            headerTitle.text = labelTitle
        }
        
        if (imageData != nil)
        {
            imageView.image = UIImage(data: imageData as! Data)
        }
        
        textView.placeholder = "Please place some comment for your moment!"
        // Do any additional setup after loading the view.
    }
    
    
    func timeStamp() -> String
    {
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyyMMddHHmm"
        
        let dateString = formatter.string(from: now)
        
        return dateString
    }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        dismiss(animated: true)
        
        let timestamp = NSDate().timeIntervalSince1970
        comment = textView.text ?? ""
        let animal = animalM()
        
        
        let urlString = "http://0.0.0.0:5000/predict"
        let imageBase64 = imageToBase64(image: self.imageData!)
        let parameters: Parameters = [
            "image":imageBase64
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        print(parameters)
        Alamofire.request(urlString, method: .post, parameters: parameters,encoding: URLEncoding.httpBody, headers: nil).responseString {
            response in
            switch response.result {
            case .success:
                self.object = JsonObject.shared.regcongitionResponse(data: response.data)
                print(response.response?.statusCode)
                print(response)
                print("Type is ")
                print(self.object!.typeName)
                animal.imageName = self.object!.typeName + self.timeStamp()
                animal.typeName = self.object!.typeName.uppercased()
                animal.comment = self.comment!
                //        animal.image = imageData
                animal.image = self.imageData
                self.buttonAtion?(animal)
                
                break
            case .failure(let error):
                print("ttt")
                let alert = UIAlertView()
                alert.title = "Title"
                alert.message = "My message"
                alert.addButton(withTitle: "Ok")
                alert.show()
                print(error)
            }
        }
        
        
        
        
        
       
        
    
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


extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.characters.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.characters.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
