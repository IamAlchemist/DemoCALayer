//
//  ItemsViewController.swift
//  CALayerDemo
//
//  Created by wizard on 12/23/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class MenuItemsViewController : UITableViewController {
    var menuItems: [(String, String)] {
        get {
            return [
                ("SimpleCALayer", "Just the basic sample"),
                ("CALayer", "Manage and animate visual content"),
                ("CAScrollLayer", "Display portion of a scrollable layer"),
                ("CATextLayer", "Render plain text or attributed strings"),
                ("AVPlayerLayer", "Display an AV player "),
                ("CAGradientLayer", "Apply a color gradient over the background"),
                ("CAReplicatorLayer", "Duplicate a source layer"),
                ("CATiledLayer", "Asynchronously draw layer content in tiles"),
                ("CAShapeLayer", "Draw using scalable vector paths"),
                ("CAEAGLLayer", "Draw OpenGL content"),
                ("CATransformLayer", "Draw 3D structures"),
                ("CAEmitterLayer", "Render animated particles")
            ]
        }
    }
    
    var navController : UINavigationController!
    var detailViewController : UIViewController!
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell")!
        cell.textLabel?.text = menuItems[indexPath.row].0
        cell.detailTextLabel?.text = menuItems[indexPath.row].1
        cell.imageView?.image = UIImage(named: menuItems[indexPath.row].0)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let identifier = menuItems[indexPath.row].0
        navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as! UINavigationController
        detailViewController = navController.topViewController
        
        detailViewController?.navigationItem.leftBarButtonItem = splitViewController!.displayModeButtonItem
        detailViewController?.navigationItem.leftItemsSupplementBackButton = true
        
        splitViewController?.showDetailViewController(navController, sender: nil)
    }
    
}
