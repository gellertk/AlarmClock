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
        tableView.separatorColor = Constant.Color.tableSeparator
        tableView.register(LapsTableViewCell.self, forCellReuseIdentifier: Constant.String.lapCellId)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constant.Color.tableSeparator
        
        return view
    }()
    
    init(interfaceType: InterfaceType) {
        super.init(frame: CGRect.zero)
        setupView(type: interfaceType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    //TODO: Convert to generic or smth
    public func updateStopwatchLabels(mainTime: TimeInterval, lapTime: TimeInterval) {
        (scrollViewElements.first as? StopwatchNumbersView)?.timeLabel.text = mainTime.convertToReadableString(timerType: .stopwatch)
        (scrollViewElements.last as? StopwatchImitationView)?.timeLabel.text = mainTime.convertToReadableString(timerType: .stopwatch)
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
        setupButtonsBy(type: type)
    }
    
    func setupConstraints() {
        
        lapAndResetButton.snp.makeConstraints {
            $0.top.equalTo(UIScreen.main.bounds.height * 0.46)
            $0.leading.equalToSuperview().offset(Constant.ViewSize.trailingLeadingDefault)
            $0.width.height.equalTo(Constant.ViewSize.circleButtonViewWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(lapAndResetButton)
            $0.trailing.equalToSuperview().offset(-Constant.ViewSize.trailingLeadingDefault)
            $0.width.height.equalTo(Constant.ViewSize.circleButtonViewWidthHeight)
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
    
    private func setupButtonsBy(type: InterfaceType) {
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
        lapAndResetButton.setupBy(type: .lapEnabled)
        startAndStopButton.setupBy(type: .stop)
    }
    
    private func setupPauseInterface() {
        lapAndResetButton.setupBy(type: .reset)
        startAndStopButton.setupBy(type: .startStopwatch)
    }
    
    private func setupInitialInterface() {
        lapAndResetButton.setupBy(type: .lapDisabled)
        startAndStopButton.setupBy(type: .startStopwatch)
        (scrollViewElements.first as? StopwatchNumbersView)?.timeLabel.text = Constant.String.stopwatchStartTime
        (scrollViewElements.last as? StopwatchImitationView)?.timeLabel.text = Constant.String.stopwatchStartTime
    }
    
}

extension StopwatchView: StopwatchViewDelegate {
    
    func didTapStartStopwatchButton() {
        stopwatchViewControllerDelegate?.startStopwatch()
        setupButtonsBy(type: .stopwatchRunning)
    }
    
    func didTapStopStopwatchButton() {
        stopwatchViewControllerDelegate?.stopStopwatch()
        setupButtonsBy(type: .stopwatchPaused)
    }
    
    func didTapLapStopwatchButton() {
        stopwatchViewControllerDelegate?.saveLap()
        setupButtonsBy(type: .stopwatchRunning)
    }
    
    func didTapDisabledLapStopwatchButton() {
        setupButtonsBy(type: .stopwatchInitial)
    }
    
    func didTapResetStopwatchButton() {
        stopwatchViewControllerDelegate?.resetStopwatch()
        setupButtonsBy(type: .stopwatchInitial)
    }
    
}
