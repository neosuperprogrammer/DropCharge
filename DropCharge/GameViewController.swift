/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import SpriteKit
import GoogleMobileAds
import Crashlytics

class GameViewController: UIViewController, GADInterstitialDelegate {
    var interstitial : GADInterstitial!

    @IBOutlet weak var GoogleBannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "Game Main Scene")
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didEnd), name: "GameEndNoti", object: nil)
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            skView.showsPhysics = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        
        self.interstitial = reloadInterstitialAd()
        
        
        #if false
            #if DEBUG
                GoogleBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            #else
                
                GoogleBannerView.adUnitID = "ca-app-pub-9254009028575157/8526879024"
            #endif
            
            
            GoogleBannerView.rootViewController = self
            GoogleBannerView.loadRequest(GADRequest())
        #endif
        
        
        
//        let button = UIButton(type: UIButtonType.RoundedRect)
//        button.frame = CGRectMake(20, 50, 100, 30)
//        button.setTitle("Crash", forState: UIControlState.Normal)
//        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        view.addSubview(button)

    }
    
//    @IBAction func crashButtonTapped(sender: AnyObject) {
//        Crashlytics.sharedInstance().crash()
//    }

    
    func didEnd(notification: NSNotification){
        self.showAd()
    }
    
    func showAd()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)//Whatever  shows the ad
        }
    }

    func reloadInterstitialAd() -> GADInterstitial {
        #if DEBUG
            let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        #else
            let interstitial = GADInterstitial(adUnitID: "ca-app-pub-9254009028575157/8679826222")
        #endif
      
        
        interstitial.delegate = self
        interstitial.loadRequest(GADRequest())
        return interstitial
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func interstitialDidDismissScreen(ad: GADInterstitial!) {
        self.interstitial = reloadInterstitialAd()
    }
}
