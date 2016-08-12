//
//  PageContentViewController.swift
//  Habitual
//
//  Created by Stefanie Seah on 12/8/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var pageImage: UIImageView!
    
    var pageIndex: Int = 0
    var titleText: String = ""
    var imageFile: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.pageImage.image = 	UIImage(named: self.imageFile)!
        self.pageTitle.text = self.titleText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
