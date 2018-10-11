//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Pat Khai on 10/8/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var deadFace: UIImageView!
    @IBOutlet weak var downArrow: UIImageView!
    @IBOutlet weak var excitedFace: UIImageView!
    @IBOutlet weak var happyFace: UIImageView!
    @IBOutlet weak var sadFace: UIImageView!
    @IBOutlet weak var tongueFace: UIImageView!
    @IBOutlet weak var winkFace: UIImageView!
    

    var pinchGesture = UIPinchGestureRecognizer()
    
    var newlyCreatedFace: UIImageView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 290
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
//        newlyCreatedFace.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanSelect(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        print("translation \(translation)")
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            let velocity = sender.velocity(in: view)
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayDown
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayUp
                }
            }
            
        }
        
        
        
        
    }
    
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    @IBAction func didPinchface(_ sender: UIPanGestureRecognizer) {
        let scale = pinchGesture.scale
        let imageView = sender.view as! UIImageView
        imageView.transform = CGAffineTransform(scaleX: 4, y: 3)
        pinchGesture.scale = 1
    }
    
    
    @IBAction func didPanface(_ sender: UIPanGestureRecognizer) {

    
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center

            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center

        } else if sender.state == .changed {
            
            let translation = sender.translation(in: view)
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

        } else if sender.state == .ended {

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
