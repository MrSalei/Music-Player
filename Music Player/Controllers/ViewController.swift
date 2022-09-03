//
//  ViewController.swift
//  Music Player
//
//  Created by luqrri on 3.09.22.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songDurationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if player?.timeControlStatus == .playing {
            player?.pause()
            wasPlaying = false
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            player?.play()
            wasPlaying = true
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    @IBAction func timeSliderAction(_ sender: Any) {
        player?.seek(to: CMTime(seconds: Double(timeSlider.value), preferredTimescale: 1000))
        timeLabel.text = timeFormat(time: Double(timeSlider.value))
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        next()
    }
    @IBAction func prevButtonPressed(_ sender: Any) {
        prev()
    }
    
    @objc func swipedRight(_ gesture:UISwipeGestureRecognizer)
    {
        next()
    }
    
    @objc func swipedLeft(_ gesture:UISwipeGestureRecognizer)
    {
        prev()
    }
    
    private let colors = Colors()
    private var player: AVPlayer?, counter = 1, obs: Any?, wasPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setup(song: counter)
        setupSwipe()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    private func setupSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    private func timeFormat(time: Double) -> String {
        let minutes: Int = Int(time) / 60, seconds: Int = Int(time) % 60
        if seconds < 10 {
            return "\(minutes):0\(seconds)"
        }
        else {
            return "\(minutes):\(seconds)"
        }
    }
    
    private func setup(song: Int) {
        switch song {
            case 1:
                first()
            case 2:
                second()
            default:
                third()
        }
    }
    
    private func first() {
        songImage.image = UIImage(named: "1")
        nameLabel.text = "Living life in the night - Cheriimoya"
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "LivingLife", ofType: "mp3")!))
        setupPlayer()
    }
    
    private func second() {
        songImage.image = UIImage(named: "2")
        nameLabel.text = "Royalty (ft. Neoni) - Egzod & Chives"
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Royalty", ofType: "mp3")!))
        setupPlayer()
    }
    
    private func third() {
        songImage.image = UIImage(named: "3")
        nameLabel.text = "Under Control - Calvin Harris, Alesso"
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "UnderControl", ofType: "mp3")!))
        setupPlayer()
    }
    
    private func setupPlayer() {
        songDurationLabel.text = timeFormat(time: (player?.currentItem?.asset.duration.seconds)!)
        timeSlider.maximumValue = Float(player?.currentItem?.asset.duration.seconds ?? 0)
        obs = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { time in
            self.timeLabel.text = self.timeFormat(time: time.seconds)
            self.timeSlider.value = Float(time.seconds)
        }
    }
    
    private func reset() {
        player?.removeTimeObserver(obs!)
        timeSlider.value = 0
        timeLabel.text = "0:00"
        setup(song: counter)
        if wasPlaying {
            player?.play()
        }
    }
    
    private func next() {
        counter += 1
        if counter == 4 { counter = 1 }
        reset()
    }
    
    private func prev() {
        counter -= 1
        if counter == 0 { counter = 3 }
        reset()
    }

}
