//
//  Colors.swift
//  Music Player
//
//  Created by luqrri on 3.09.22.
//

import UIKit

class Colors {
    var gl: CAGradientLayer!

    init() {
        let top = UIColor(red: 153.0 / 255.0, green: 50.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).cgColor
        let bottom = UIColor(red: 75.0 / 255.0, green: 0.0 / 255.0, blue: 130.0 / 255.0, alpha: 1.0).cgColor
        self.gl = CAGradientLayer()
        self.gl.colors = [top, bottom]
        self.gl.locations = [0.0, 1.0]
    }
}
