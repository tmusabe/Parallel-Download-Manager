//
//  ViewController.swift
//  Parallel Download
//
//  Created by Taif Al Musabe on 1/23/19.
//  Copyright © 2019 taifalmusabe. All rights reserved.
//

import UIKit

typealias DownloadCompletionBlock = (_ data: Data?, _ error: Error?) -> Void
typealias ParallelDownloadCompletion = (_ data: [Data]?,_ error: [Error]?) -> Void

class ViewController: UIViewController, ParallelDownloadMangerDelegate {
    @IBOutlet weak var progressView: UIProgressView!

    @IBOutlet weak var successfulLabel: UILabel!
    
    private let urls = ["https://i.imgur.com/UvqEgCv.png", "https://i.imgur.com/dZ5wRtb.png", "https://i.imgur.com/tPzTg7A.jpg"];
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
        progressView.isHidden = true
        successfulLabel.isHidden = true
        ParallelDownloadManger.sharedInstance.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        if sender is UIButton {
            let button = sender as! UIButton
            button.isHidden = true
            
        }
        progressView.isHidden = false
        ParallelDownloadManger.sharedInstance.parallelDownloadingForURLs(urls) { (datas, errors) in
            print(datas)
            print(errors)
            DispatchQueue.main.async {
                self.progressView.isHidden = true
                self.successfulLabel.isHidden = false
            }
        }
    }
    
    func getDataTaskCompletedFraction(fractionComplete: Double) {
        progressView.progress = Float(fractionComplete)
    }
    
}

