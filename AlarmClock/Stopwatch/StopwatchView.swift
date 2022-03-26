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
    
    private lazy var scrollViewElements = [StopwatchNumbersView(), StopwatchImitationView()]
    
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var lapAndResetButton: CircleButtonView = {
        
        return CircleButtonView(delegate: self)
    }()
    
    private lazy var startAndStopButton: CircleButtonView = {
        
        return CircleButtonView(delegate: self)
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = scrollViewElements.count
        
        return pageControl
    }()
    
    public lazy var lapsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorColor = Constants.tableSeparatorColor
        tableView.register(LapsTableViewCell.self, forCellReuseIdentifier: Constants.lapCellId)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.tableSeparatorColor
        
        return view
    }()
    
    init(interfaceType: InterfaceType) {
        super.init(frame: CGRect.zero)
        setupView()
        setupButtonBy(type: interfaceType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [scrollView,
         lapAndResetButton,
         startAndStopButton,
         pageControl,
         lapsTableView,
         separatorView].forEach {
            
            addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        lapAndResetButton.snp.makeConstraints {
            $0.top.equalTo(UIScreen.main.bounds.height * 0.45)
            $0.leading.equalToSuperview().offset(Constants.defaultBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(lapAndResetButton)
            $0.trailing.equalToSuperview().offset(-Constants.defaultBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let scrollViewElementHeight = pageControl.frame.origin.y - 1
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(scrollViewElements.count),
                                        height: scrollViewElementHeight)
        
        for (index, element) in scrollViewElements.enumerated() {
            let xOffset = frame.size.width * CGFloat(index)
            
            scrollView.addSubview(element)
            element.snp.makeConstraints {
                $0.top.width.equalToSuperview()
                $0.height.equalTo(scrollViewElementHeight)
                $0.left.equalToSuperview().offset(xOffset)
            }
        }
    }
    
    func updateStopwatchLabels(mainTime: TimeInterval, lapTime: TimeInterval) {
        (scrollViewElements.first as? StopwatchNumbersView)?.timeLabel.text = mainTime.convertToStopwatchFormatString()
        (scrollViewElements.last as? StopwatchImitationView)?.timeLabel.text = mainTime.convertToStopwatchFormatString()
        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
            cell.updateStopwatch(lapTime: lapTime)
        }
    }
    
    private func setupButtonBy(type: InterfaceType) {
        switch type {
        case .stopwatchInitial:
            setupInitialInterface()
        case .stopwatchRunning:
            setupRunningInterface()
        case .stopwatchPause:
            setupPauseInterface()
        }
    }
    
    private func setupRunningInterface() {
        lapAndResetButton.setupBy(type: .lapEnabled)
        startAndStopButton.setupBy(type: .stop)
    }
    
    private func setupPauseInterface() {
        lapAndResetButton.setupBy(type: .reset)
        startAndStopButton.setupBy(type: .start)
    }
    
    private func setupInitialInterface() {
        lapAndResetButton.setupBy(type: .lapDisabled)
        (scrollViewElements.first as? StopwatchNumbersView)?.timeLabel.text = Constants.stopwatchStartTime
        (scrollViewElements.last as? StopwatchImitationView)?.timeLabel.text = Constants.stopwatchStartTime
    }
    
}

extension StopwatchView: StopwatchViewDelegate {
    
    func didTapStartStopwatchButton() {
        stopwatchViewControllerDelegate?.startStopwatch()
        setupButtonBy(type: .stopwatchRunning)
    }
    
    func didTapStopStopwatchButton() {
        stopwatchViewControllerDelegate?.stopStopwatch()
        setupButtonBy(type: .stopwatchPause)
    }
    
    func didTapLapStopwatchButton() {
        stopwatchViewControllerDelegate?.saveLap()
        setupButtonBy(type: .stopwatchRunning)
    }
    
    func didTapDisabledLapStopwatchButton() {
        setupButtonBy(type: .stopwatchInitial)
    }
    
    func didTapResetStopwatchButton() {
        stopwatchViewControllerDelegate?.resetStopwatch()
        setupButtonBy(type: .stopwatchInitial)
    }
    
}

extension StopwatchView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
    
}
