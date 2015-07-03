//  Created by Roman Petrov on 02/07/15.
//  Copyright (c) 2015 Kentor. All rights reserved.

import UIKit

class MainViewController: UIViewController, PlayerDelegate {
    let videoPath = NSBundle.mainBundle().pathForResource("cat", ofType: "mp4")
    
    private var player:Player!
    @IBOutlet var childView:UIView!
    @IBOutlet var playPauseButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.player = Player()
        self.player.delegate = self
        self.player.view.frame = childView.bounds
        self.addChildViewController(self.player)
        childView.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        self.player.path = videoPath
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        playOrPauseVideo()
    }
    
    @IBAction func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        playOrPauseVideo()
    }
    
    func playOrPauseVideo() {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.Stopped.rawValue:
            setButtonTextPause()
            self.player.playFromBeginning()
        case PlaybackState.Paused.rawValue:
            setButtonTextPause()
            self.player.playFromCurrentTime()
        case PlaybackState.Playing.rawValue:
            setButtonTextPlay()
            self.player.pause()
        case PlaybackState.Failed.rawValue:
            setButtonTextPlay()
            self.player.pause()
        default:
            self.player.pause()
        }
    }
    
    func setButtonTextPlay() {
        setButtonText("Play")
    }

    func setButtonTextPause() {
        setButtonText("Pause")
    }

    func setButtonText(text:String) {
        playPauseButton.setTitle(text, forState: UIControlState.Normal)
    }

    func playerPlaybackDidEnd(player: Player) {
        setButtonTextPlay()
    }

    func playerReady(player: Player) {
    }
    
    func playerPlaybackStateDidChange(player: Player) {
    }
    
    func playerBufferingStateDidChange(player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
    }
}
