//
//  SceneDelegate.swift
//  MvcProduct
//
//  Created by Mahmoud on 21/06/2022.
//

import UIKit
import SystemConfiguration

 
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var reachabilityManager = ReachabilityManager()
    var reachabilityBanner = ReachabilityBanner()

    func checkReachability() {
            reachabilityManager.start(listener: self)
        }
 

    // Create New Strory Board
 
    func setRootViewController(_ viewController: UIViewController,
                                   duration: TimeInterval = 0.55,
                                   transition: UIView.AnimationOptions = .showHideTransitionViews ) {
           
        window?.rootViewController = viewController
        window?.backgroundColor = UIColor.white
        UIView.transition(with: window ?? UIWindow(), duration: duration, options: transition, animations: nil, completion: nil)
        }
    
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
 
         //declare this inside of viewWillAppear
        checkReachability()
        FacIDViewController.signal.authenticate()
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
         
//        let storyboard = UIStoryboard.init(name: "All", bundle: nil)
//             let viewController = storyboard.instantiateInitialViewController()!
//              let navVC = storyboard.instantiateViewController(identifier: "TabBarVC") as! UITabBarController
//                setRootViewController(viewController, transition: .transitionCrossDissolve)
//        window?.rootViewController = navVC
        
    
    }
   

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
     
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.

  
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

extension SceneDelegate: ReachabilityManagerListener {

    func notifyChange(with flags: SCNetworkReachabilityFlags) {
        reachabilityBanner.notifyStatusBar(in: window, for: flags)
    }
}
