//
//  VideoLaucher.swift
//  demoLayout
//
//  Created by DuyNguyen on 7/27/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    var isPlay = false
    var mVideoPlayer:AVPlayer?
    var TotalTime:Float64 = 0
    var mTimer:Timer?
    var BottomControllViewContraint:NSLayoutConstraint?
    var mGradientView:CAGradientLayer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let string = "https://srv-file8.gofile.io/download/ZSAc1p/IMG_0325.MOV"
        let urlString = URL(string: string)
        mVideoPlayer = AVPlayer.init(url: urlString!)
        let mPlayerLayer = AVPlayerLayer.init(player: mVideoPlayer)
        mVideoPlayer!.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        let mCMtime = CMTime.init(value: 1, timescale: 2)
        mVideoPlayer?.addPeriodicTimeObserver(forInterval: mCMtime, queue: DispatchQueue.main, using: { (Currentime) in
            let seconds = CMTimeGetSeconds(Currentime)
            self.mCurrentPlayTime.text = self.ConvertSecondsToText(seconds: Int64(seconds))
            self.mSlider.value = Float(CMTimeGetSeconds(Currentime) / self.TotalTime)
            print(seconds)
        })
        mPlayerLayer.frame = self.frame
        self.layer.addSublayer(mPlayerLayer)
        mVideoPlayer!.play()
        mPlayPauseButton.isHidden = true
        self.addSubview(mIncaditorView)
        self.addSubview(mPlayPauseButton)
        self.addSubview(mStackView)
        setUpConstraintIncaditorView()
        setUpConstraintPausePlayButton()
        setUpConstraintStackView()
        setUpGradientView()
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showControllViewFor4s)))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            mIncaditorView.stopAnimating()
            mPlayPauseButton.isHidden = false
            isPlay = true
            if let duration = mVideoPlayer?.currentItem?.duration {
                self.TotalTime = CMTimeGetSeconds(duration)
                mTotalPlayTime.text = ConvertSecondsToText(seconds: Int64(self.TotalTime))
                
            }
        }
    }
    
    
    func ConvertSecondsToText(seconds:Int64) -> String {
        let hours = String.init(format: "%02d",  seconds / 3600)
        let minnute = String.init(format: "%02d", (seconds % 3600) / 60)
        let mseccond = String.init(format: "%02d", seconds % 60)
        if seconds / 3600 == 0 {
            return ("\(minnute):\(mseccond)")
        } else {
            return ("\(hours):\(minnute):\(mseccond)")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mIncaditorView:UIActivityIndicatorView = {
        let IncaditorView = UIActivityIndicatorView.init()
        IncaditorView.style = .large
        IncaditorView.startAnimating()
        IncaditorView.translatesAutoresizingMaskIntoConstraints = false
        return IncaditorView
    }()
    
    lazy var mPlayPauseButton:UIButton = {
        let PlayPauseButton = UIButton.init(frame: CGRect.zero)
        PlayPauseButton.translatesAutoresizingMaskIntoConstraints = false
        PlayPauseButton.addTarget(self, action: #selector(tapPlayPauseButton), for: .touchUpInside)
        PlayPauseButton.setImage(UIImage.init(named: "Pause"), for: .normal)
        return PlayPauseButton
    }()
    
    
    let mCurrentPlayTime:UILabel = {
        let CurrentPlayTime = UILabel.init()
        CurrentPlayTime.text = "00:00"
        CurrentPlayTime.textColor = .white
        return CurrentPlayTime
    }()
    
    let mTotalPlayTime:UILabel = {
        let TotalPlayTime = UILabel.init()
        TotalPlayTime.text = "00:00"
        TotalPlayTime.textColor = .white
        return TotalPlayTime
    }()
    
    lazy var mSlider:UISlider = {
        let Slider = UISlider.init()
        Slider.thumbTintColor = .red
        Slider.minimumTrackTintColor = .red
        Slider.maximumTrackTintColor = .white
        Slider.addTarget(self, action: #selector(seekSlider), for: .valueChanged)
        return Slider
    }()
    
    @objc func seekSlider() {
        let time = Double(mSlider.value) * self.TotalTime
        let cmtime = CMTime.init(value: CMTimeValue(time), timescale: 1)
        mVideoPlayer?.seek(to: cmtime)
    }
    
    lazy var mStackView:UIStackView = {
        let StackView = UIStackView.init(arrangedSubviews: [self.mCurrentPlayTime, self.mSlider ,mTotalPlayTime])
        StackView.axis = .horizontal
        StackView.distribution = .fill
        StackView.spacing = 10
        StackView.translatesAutoresizingMaskIntoConstraints = false
        return StackView
    }()
    
    func setUpConstraintIncaditorView() {
        mIncaditorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mIncaditorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mIncaditorView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        mIncaditorView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setUpConstraintPausePlayButton() {
        mPlayPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mPlayPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mPlayPauseButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        mPlayPauseButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setUpConstraintStackView() {
        mStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        mStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        BottomControllViewContraint = mStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        BottomControllViewContraint?.isActive = true
        mStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    @objc func tapPlayPauseButton() {
        if isPlay {
            mPlayPauseButton.setImage(UIImage.init(named: "Play"), for: .normal)
            self.showControllView()
            
            self.mVideoPlayer?.pause()
            
        } else {
            mPlayPauseButton.setImage(UIImage.init(named: "Pause"), for: .normal)
            self.hideControllView()
            self.mVideoPlayer?.play()
            
        }
        isPlay = !isPlay
    }
    
    private func setUpGradientView() {
        self.mGradientView = CAGradientLayer.init()
        self.mGradientView!.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        self.mGradientView!.frame = self.frame
        self.mGradientView!.locations = [0.7, 1.2]
        self.layer.addSublayer(self.mGradientView!)
    }
    
    @objc func showControllView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.mStackView.alpha = 1
            self.mPlayPauseButton.alpha = 1
            self.mGradientView?.isHidden = false
        }) { (Bool) in
            print(Bool)
        }
    }
    
    @objc func hideControllView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.mStackView.alpha = 0
            self.mPlayPauseButton.alpha = 0
            self.mGradientView?.isHidden = true
        }) { (Bool) in
            print(Bool)
            self.mTimer?.invalidate()
            self.mTimer = nil
        }
    }
    
    @objc func showControllViewFor4s (){
        self.showControllView()
        mTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(hideControllView), userInfo: nil, repeats: false)
    }
}

class VideoLaucher: NSObject {
    func showVideoPlayer() {
        print("showVideoPlayer")
        if let keywindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow }) {
            let view = UIView(frame: CGRect(x: keywindow.frame.width - 10, y: keywindow.frame.height - 10 , width: 10, height: 10))
            let mVideoPlayerView = VideoPlayerView.init(frame: CGRect.init(x: 0, y: 0, width: keywindow.frame.width, height:keywindow.frame.width * (9/16)))
            mVideoPlayerView.backgroundColor = .black
            view.backgroundColor = .black
            view.addSubview(mVideoPlayerView)
            keywindow.addSubview(view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                view.frame = keywindow.frame
            }) { (Bool) in
            }
        }
    }
}

