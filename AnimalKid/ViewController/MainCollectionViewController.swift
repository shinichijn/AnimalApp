//
//  MainCollectionViewController.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 3/2/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let listReuseIdentifier = "ListCell"
private let gridReuseIdentifier = "GridCell"
 let identify = "detailTypeTable"
enum LayoutOption {
    
    case list
    case smallGrid
    case largeGrid
    
}

struct animalCatgs {
    let type:String
    let color:UIColor
}


class MainCollectionViewController: UICollectionViewController{

    
    @IBOutlet var collectMainView: UICollectionView!
    
    
    private let animalCatg = [
    animalCatgs(type: "BUTTERFLY", color: UIColor(hex: "#a1c4fdff")!),
    animalCatgs(type: "CAT", color: UIColor(hex: "#13547aff")!),
    animalCatgs(type: "CHICKEN", color: UIColor(hex: "#ffecd2ff")!),
    animalCatgs(type: "DOG", color: UIColor(hex: "#ff9a9eff")!),
    animalCatgs(type: "HORSE", color: UIColor(hex: "#cfd9dfff")!),
    animalCatgs(type: "SHEEP", color: UIColor(hex: "#a1c4fdff")!),
    animalCatgs(type: "COW", color: UIColor(hex: "#ff9a9eff")!),
    animalCatgs(type: "SQUIRREL", color: UIColor(hex: "#89f7feff")!)
    ]
    private var layoutOption: LayoutOption = .largeGrid
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupCollectionView()
        setupNavigationBarItem()
        setupLayout(with: view.bounds.size)
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        // Do any additional setup after loading the view.
    }
   
    
    private func setupCollectionView() {
       
        
        collectionView?.register(UINib(nibName: "CollectViewCell", bundle: nil), forCellWithReuseIdentifier: listReuseIdentifier)
        collectionView?.register(UINib(nibName: "CollectViewCell", bundle: nil), forCellWithReuseIdentifier: gridReuseIdentifier)
    }
    
    
    private func setupLayout(with containerSize: CGSize) {
        guard let flowLayout = collectMainView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        switch layoutOption {
        case .list:
            break
            
        case .largeGrid, .smallGrid:
            let minItemWidth: CGFloat
            if layoutOption == .smallGrid {
                minItemWidth = 106
            } else {
                minItemWidth = 160
            }
            
            let numberOfCell = containerSize.width / minItemWidth
            let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
            let height = ceil(width * (4.0 / 3.0))
            
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.itemSize = CGSize(width: width, height: height)
            flowLayout.sectionInset = .zero
        }
        
        collectMainView?.reloadData()
    }
    
    
    
    
    private func setupNavigationBarItem() {
        let barButtonItem = UIBarButtonItem(title: "Layout", style: .plain, target: self, action: #selector(layoutTapped(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupLayout(with: size)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayout(with: view.bounds.size)
    }
    
    
    @objc private func layoutTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Select Layout", message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        alertController.addAction(UIAlertAction(title: "List", style: .default, handler: { (_) in
            self.layoutOption = .list
        }))
        
        alertController.addAction(UIAlertAction(title: "Large Grid", style: .default, handler: { (_) in
            self.layoutOption = .largeGrid
        }))
        
        alertController.addAction(UIAlertAction(title: "Small Grid", style: .default, handler: { (_) in
            self.layoutOption = .smallGrid
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return animalCatg.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        switch layoutOption {
        case .list:
            let cell = collectMainView.dequeueReusableCell(withReuseIdentifier: listReuseIdentifier, for: indexPath) as! CollectViewCell
            let movie = animalCatg[indexPath.item]
             cell.data = movie
            return cell
            
        case .largeGrid:
            let cell = collectMainView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! CollectViewCell
            let movie = animalCatg[indexPath.item]
            cell.data = movie
            return cell
            
        case .smallGrid:
            let cell = collectMainView.dequeueReusableCell(withReuseIdentifier: gridReuseIdentifier, for: indexPath) as! CollectViewCell
            let movie = animalCatg[indexPath.item]
              cell.data = movie
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you tap me")
        print(indexPath.item)
       
        let item = animalCatg[indexPath.item]
        performSegue(withIdentifier: identify, sender: item)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! animalCatgs
        if segue.identifier == identify
        {
            if let vc = segue.destination as? detailTypeTableViewController {
                vc.typeData = item
            }
            
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
