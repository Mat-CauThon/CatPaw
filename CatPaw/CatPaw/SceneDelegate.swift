//
//  SceneDelegate.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if defaults.bool(forKey: "First") == true {
            
            print("Second")
            defaults.set(false, forKey: "First")
        } else {
            
            print("First")
            defaults.set(true, forKey: "First")
        }
        

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            
            let randomCat = randomCatViewController()
            let listOfCats = listOfCatsViewController()
            let savedCats = savedCatsViewController()
            let help = helpViewControlelr()
            let recognize = recognizeViewController()
            
            let tabBarController = UITabBarController()
            tabBarController.setViewControllers([randomCat, listOfCats, savedCats, recognize, help], animated: false)
            window.rootViewController = tabBarController
            
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func randomCatViewController() -> UIViewController {
        let randomCatView = RandomCatView()
        let randomCatViewController = RandomCatViewController(rootView: randomCatView)
        randomCatViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return randomCatViewController
    }
    
    func listOfCatsViewController() -> UIViewController {
        let listOfCatsView = ListOfCatsView()
        let listController = ListOfCatsViewController(rootView: listOfCatsView)
        listController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "square.stack.3d.down.right.fill"), tag: 1)
        return listController
    }
    
    func savedCatsViewController() -> UIViewController {
        let savedView = SavedCatsView()
        let savedViewController = SavedCatsViewController(rootView: savedView)
        savedViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "tray.and.arrow.down.fill"), tag: 2)
        return savedViewController
    }
    
    func helpViewControlelr() -> UIViewController {
        let helpView = HelpView()
        let helpViewControlelr = HelpViewController(rootView: helpView)
        helpViewControlelr.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "questionmark"), tag: 3)
        return helpViewControlelr
    }
    
    func recognizeViewController() -> UIViewController {
        let recognizeView = RecognizeView()
        let recognizeViewControlelr = RecognizeViewController(rootView: recognizeView)
        recognizeViewControlelr.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "camera.fill"), tag: 4)
        return recognizeViewControlelr
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        
        PersistentService.saveContext()
    }


}

