//
//  StopWatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

protocol StopwatchViewDelegate: AnyObject {
    func didTapStartStopwatchButton()
    func didTapStopStopwatchButton()
    func didTapLapStopwatchButton()
    func didTapResetStopwatchButton()
    func didTapDisabledLapStopwatchButton()
}

class StopwatchView: UIView {
    
    public weak var stopwatchViewControllerDelegate: StopwatchViewControllerDelegate?
    
    private let digitalFormatView = DigitalFormatView()
    private let clockFaceView = ClockFaceView()
    
    private lazy var scrollViewElements = [digitalFormatView, clockFaceView]
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var lapAndResetButton: CircleButtonView = {
        let button = CircleButtonView()
        button.stopwatchViewDelegate = self
        
        return button
    }()
    
    private lazy var startAndStopButton: CircleButtonView = {
        let button = CircleButtonView()
        button.stopwatchViewDelegate = self
        
        return button
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = scrollViewElements.count
        
        return pageControl
    }()
    
    private(set) lazy var lapsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorColor = K.Color.tableSeparator
        tableView.register(LapsTableViewCell.self, forCellReuseIdentifier: LapsTableViewCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = K.Color.tableSeparator
        
        return view
    }()
    
    init(interfaceType: InterfaceType) {
        super.init(frame: .zero)
        setupView(type: interfaceType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fillScrollView()
    }
    
    private func fillScrollView() {
        let scrollViewElementHeight = pageControl.frame.origin.y - 1
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(scrollViewElements.count),
                                        height: scrollViewElementHeight)
        
        for (index, element) in scrollViewElements.enumerated() {
            let xOffset = frame.size.width * CGFloat(index)
            
            scrollView.addSubview(element)
            element.snp.makeConstraints {
                $0.top.width.equalToSuperview()
                $0.height.equalTo(scrollViewElementHeight)
                $0.leading.equalToSuperview().offset(xOffset)
            }
        }
    }
    
    public func updateStopwatchLabels(mainTime: TimeInterval, lapTime: TimeInterval) {
        guard let stopwatchViewControllerDelegate = stopwatchViewControllerDelegate else {
            return
        }
        let updatedTime = mainTime.convertToFormat(by: .stopwatch)
        digitalFormatView.timeLabel.text = updatedTime
        clockFaceView.update(secondsHandTime: mainTime,
                             lapHandTime: stopwatchViewControllerDelegate.lastLapTime(),
                             isRunning: stopwatchViewControllerDelegate.isRunning())
        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
            cell.updateStopwatch(lapTime: lapTime)
        }
    }
    
}

private extension StopwatchView {
    
    func setupView(type: InterfaceType) {
        [scrollView,
         lapAndResetButton,
         startAndStopButton,
         pageControl,
         lapsTableView,
         separatorView].forEach {
            
            addSubview($0)
        }
        
        setupConstraints()
        setupButtons(by: type)
    }
    
    func setupConstraints() {
        
        lapAndResetButton.snp.makeConstraints {
            $0.top.equalTo(UIScreen.main.bounds.height * 0.46)
            $0.leading.equalToSuperview().offset(K.Numeric.trailingLeadingDefaultBorder)
            $0.width.height.equalTo(K.Numeric.circleButtonViewWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(lapAndResetButton)
            $0.trailing.equalToSuperview().offset(-K.Numeric.trailingLeadingDefaultBorder)
            $0.width.height.equalTo(K.Numeric.circleButtonViewWidthHeight)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(lapAndResetButton)
            $0.trailing.equalTo(startAndStopButton)
            $0.top.equalTo(lapAndResetButton.snp.bottom).offset(15)
            $0.height.equalTo(0.5)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(lapAndResetButton)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lapsTableView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.equalTo(lapAndResetButton)
            $0.trailing.equalTo(startAndStopButton)
            $0.bottomMargin.equalToSuperview()
        }
    }
    
    private func setupButtons(by type: InterfaceType) {
        switch type {
        case .stopwatchInitial:
            setupInitialInterface()
        case .stopwatchRunning:
            setupRunningInterface()
        case .stopwatchPaused:
            setupPauseInterface()
        default: break
        }
    }
    
    private func setupRunningInterface() {
        lapAndResetButton.setup(by: .lapEnabled)
        startAndStopButton.setup(by: .stop)
    }
    
    private func setupPauseInterface() {
        lapAndResetButton.setup(by: .reset)
        startAndStopButton.setup(by: .startStopwatch)
    }
    
    private func setupInitialInterface() {
        lapAndResetButton.setup(by: .lapDisabled)
        startAndStopButton.setup(by: .startStopwatch)
        digitalFormatView.timeLabel.text = K.String.stopwatchStartTime
    }
    
}

extension StopwatchView: StopwatchViewDelegate {
    
    func didTapStartStopwatchButton() {
        guard let stopwatchViewControllerDelegate = stopwatchViewControllerDelegate else {
            return
        }
        stopwatchViewControllerDelegate.startStopwatch()
        setupButtons(by: .stopwatchRunning)
        if stopwatchViewControllerDelegate.isPaused() {
            clockFaceView.resumeHandsAnimation()
        } else {
            clockFaceView.startHandsAnimation(0, 0)
        }
    }
    
    func didTapStopStopwatchButton() {
        stopwatchViewControllerDelegate?.stopStopwatch()
        setupButtons(by: .stopwatchPaused)
        clockFaceView.pauseHandsAnimation()
    }
    
    func didTapLapStopwatchButton() {
        stopwatchViewControllerDelegate?.saveLap()
        setupButtons(by: .stopwatchRunning)
        clockFaceView.startLapHandAnimation()
    }
    
    func didTapDisabledLapStopwatchButton() {
        setupButtons(by: .stopwatchInitial)
    }
    
    func didTapResetStopwatchButton() {
        stopwatchViewControllerDelegate?.resetStopwatch()
        setupButtons(by: .stopwatchInitial)
        clockFaceView.resetHandsAnimation()
    }
    
}
