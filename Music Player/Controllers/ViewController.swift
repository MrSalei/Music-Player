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
        
    }
    @IBAction func prevButtonPressed(_ sender: Any) {
        
    }
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "LivingLife", ofType: "mp3")!))
        songDurationLabel.text = timeFormat(time: (player?.currentItem?.asset.duration.seconds)!)
        timeSlider.maximumValue = Float(player?.currentItem?.asset.duration.seconds ?? 0)
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { time in
            self.timeLabel.text = self.timeFormat(time: time.seconds)
            self.timeSlider.value = Float(time.seconds)
        }
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


}

