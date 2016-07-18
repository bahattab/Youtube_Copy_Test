//
//  ViewController.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 17/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    /*var videos: [Video] = {
        
        var kanyeChannel = Channel()
        kanyeChannel.name = "KanyeIsTheBestChannel"
        kanyeChannel.profileImageName = "kanye_profile"
        
       var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thumnailImageName = "swift-youtube"
        blankSpaceVideo.channel = kanyeChannel
        blankSpaceVideo.numberOfViews = 234343223
        
        var badBloodVideo = Video()
        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        badBloodVideo.thumnailImageName = "taylor_swift_bad_blood"
        badBloodVideo.channel = kanyeChannel
        badBloodVideo.numberOfViews = 834734728
        
        return [blankSpaceVideo, badBloodVideo]
    }()
     */
    
    var videos: [Video]?
 
    
    //var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetch Videos
        fetchVideos()
        
        //Delete Translucent
        navigationController?.navigationBar.translucent = false
        
        //Set new navigation item title
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    let menuBar: MenuBar = {
        let nb = MenuBar()
        return nb
    }()
    
    func fetchVideos(){
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    //print(dictionary["title"])
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos?.append(video)
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.collectionView?.reloadData()
                })
                

            } catch let jsonError {
                print(jsonError)
            }
            
            
            
        }.resume()
    }
    
    private func setupMenuBar(){
        
        view.addSubview(menuBar)
        view.addConstrainstWithFormat("H:|[v0]|", views: menuBar)
        view.addConstrainstWithFormat("V:|[v0(50)]", views: menuBar)
        
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let moreButton = UIBarButtonItem(image:moreImage, style: .Plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    func handleSearch(){
        
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
        
    }()
    
    func handleMore(){
        //Show Menu
        settingsLauncher.showSettings()
        
    }
    
    func showControllerForSetting(setting: Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.whiteColor()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos?.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //To display videos, they should have a ratio of 16/9
        //We substract the padding and apply the ratio.
        let height = (view.frame.width - 16 - 16) * 9/16
        //For the final height we have to add the contribution of the other elements
        //88 = 8  + 36 + 44
        return CGSizeMake(view.frame.width, height + 16 + 88)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }


}




