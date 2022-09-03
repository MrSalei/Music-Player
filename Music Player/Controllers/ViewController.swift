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
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if player?.timeControlStatus == .playing {
            player?.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            player?.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    @IBAction func timeSliderAction(_ sender: Any) {
        player?.seek(to: CMTime(seconds: Double(timeSlider.value), preferredTimescale: 1000))
        timeLabel.text = timeFormat(time: Double(timeSlider.value))
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        counter += 1
        if counter == 4 { counter = 1 }
        reset()
    }
    @IBAction func prevButtonPressed(_ sender: Any) {
        counter -= 1
        if counter == 0 { counter = 3 }
        reset()
    }
    
    private let colors = Colors()
    var player: AVPlayer?, counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setup(song: counter % 3)
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
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
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "LivingLife", ofType: "mp3")!))
        songDurationLabel.text = timeFormat(time: (player?.currentItem?.asset.duration.seconds)!)
        timeSlider.maximumValue = Float(player?.currentItem?.asset.duration.seconds ?? 0)
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { time in
            self.timeLabel.text = self.timeFormat(time: time.seconds)
            self.timeSlider.value = Float(time.seconds)
        }
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    private func second() {
        songImage.image = UIImage(named: "2")
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Royalty", ofType: "mp3")!))
        songDurationLabel.text = timeFormat(time: (player?.currentItem?.asset.duration.seconds)!)
        timeSlider.maximumValue = Float(player?.currentItem?.asset.duration.seconds ?? 0)
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { time in
            self.timeLabel.text = self.timeFormat(time: time.seconds)
            self.timeSlider.value = Float(time.seconds)
        }
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    private func third() {
        songImage.image = UIImage(named: "3")
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "UnderControl", ofType: "mp3")!))
        songDurationLabel.text = timeFormat(time: (player?.currentItem?.asset.duration.seconds)!)
        timeSlider.maximumValue = Float(player?.currentItem?.asset.duration.seconds ?? 0)
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { time in
            self.timeLabel.text = self.timeFormat(time: time.seconds)
            self.timeSlider.value = Float(time.seconds)
        }
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    private func reset() {
        player = nil
        timeSlider.value = 0
        timeLabel.text = "0:00"
        setup(song: counter % 3)
    }

}
