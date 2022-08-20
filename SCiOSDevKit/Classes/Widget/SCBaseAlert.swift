//
//  SCBaseAlert.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
import SnapKit

extension SCBaseAlert{
    public enum Position{
        case center
        case bottom
        case top
        case right
        case left
    }
}


open class SCBaseAlert: UIViewController{
    public let position: Position
    ///横屏时的弹窗位置
    open var hrzPosition: Position?
    open var tapToDismiss: Bool = true
    open var fromColor: UIColor = .clear
    open var toColor: UIColor = .clear
    
    public init(position: Position){
        self.position = position
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        transitioningDelegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink.withAlphaComponent(0.3)
        return view
    }()
    
    open lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    open lazy var closeButton: SCButton = {
        let btn = SCButton()
        btn.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
        return btn
    }()
    
    open lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapSelf))
        tap.delegate = self
        return tap
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if tapToDismiss{
            view.addGestureRecognizer(tap)
        }
        configureUI()
    }
}

//MARK:-- Configure UI
extension SCBaseAlert{
    private func configureUI(){
        view.addSubview(containerView)
        containerView.frame = .init(x: 0, y: 0, width: SC_SCREEN_WIDTH, height: SC_SCREEN_WIDTH)
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.left.equalTo(containerView.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(containerView.safeAreaLayoutGuide.snp.right)
            $0.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(containerView.safeAreaLayoutGuide.snp.top)
        }
    }
}


extension SCBaseAlert: UIGestureRecognizerDelegate{
    @objc private func tapSelf(){
        dismiss(animated: true)
    }
    
    @objc private func tapClose(){
        dismiss(animated: true)
    }
    
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let loc = gestureRecognizer.location(in: view)
        return !containerView.frame.contains(loc)
    }
}

extension SCBaseAlert: UIViewControllerTransitioningDelegate{
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }
}

extension SCBaseAlert: UIViewControllerAnimatedTransitioning{
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let isPresenting = view.superview == nil
        let tstContainer = transitionContext.containerView
        var targetPosition = position
        
        /*
         case unknown = 0
         case portrait = 1 // Device oriented vertically, home button on the bottom
         case portraitUpsideDown = 2 // Device oriented vertically, home button on the top
         case landscapeLeft = 3 // Device oriented horizontally, home button on the right
         case landscapeRight = 4 // Device oriented horizontally, home button on the left
         case faceUp = 5 // Device oriented flat, face up
         case faceDown = 6 // Device orient
         */
        let deviceOrient = UIDevice.current.orientation
        if deviceOrient.isLandscape,
           let hrzP = self.hrzPosition
        {
            targetPosition = hrzP
        }
        
        
        if isPresenting{
            tstContainer.addSubview(view)
            switch targetPosition {
            case .center:
                containerView.center.x = view.bounds.width / 2
            case .bottom:
                let safeBottom = view.safeAreaInsets.bottom
                containerView.frame.size.height += safeBottom
                containerView.center.x = view.bounds.width / 2
                containerView.frame.origin.y = view.bounds.height
            case .top:
                let safeTop = view.safeAreaInsets.top
                containerView.frame.size.height += safeTop
                containerView.center.x = view.bounds.width / 2
                containerView.frame.origin.y = -containerView.frame.height
            case .right:
                let safeRight = view.safeAreaInsets.right
                containerView.frame.size.width += safeRight
                containerView.center.y = view.bounds.height / 2
                containerView.frame.origin.x = view.bounds.width
            case .left:
                let safeLeft = view.safeAreaInsets.left
                containerView.frame.size.width += safeLeft
                containerView.center.y = view.bounds.height / 2
                containerView.frame.origin.x = -containerView.bounds.width
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.backgroundColor = self.toColor
                switch targetPosition {
                case .center:
                    self.containerView.center = .init(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
                case .bottom:
                    self.containerView.frame.origin.y = self.view.bounds.height - self.containerView.frame.height
                case .top:
                    self.containerView.frame.origin.y = 0
                case .right:
                    self.containerView.frame.origin.x = self.view.bounds.width - self.containerView.frame.width
                case .left:
                    self.containerView.frame.origin.x = 0
                }
            }completion: { _ in
                transitionContext.completeTransition(true)
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                switch targetPosition {
                case .center, .bottom:
                    self.containerView.frame.origin.y = self.view.frame.height
                case .top:
                    self.containerView.frame.origin.y = -self.containerView.frame.height
                case .right:
                    self.containerView.frame.origin.x = self.view.frame.width
                case .left:
                    self.containerView.frame.origin.x = -self.containerView.frame.width
                }
            }completion: { _ in
                self.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }
    
}
    
