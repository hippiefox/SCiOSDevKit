//
//  SCWebViewController.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
import SnapKit
import WebKit

private let __progressKP = "estimatedProgress"
private let __canGoBackKP = "canGoBack"

open class SCWebviewController: SCViewController {
    open var initialTitle: String?

    open var progressTintColor: UIColor = .blue {
        didSet { progressView.tintColor = progressTintColor }
    }

    open var progressBGColor: UIColor = .white {
        didSet { progressView.trackTintColor = progressBGColor }
    }

    public init(urlString: String, msgs: [String] = []) {
        self.urlString = urlString
        self.msgs = msgs
        super.init(nibName: nil, bundle: nil)
    }

    public let urlString: String
    private var msgs: [String] = []
    private var hasShowWeb = false
    public var isForbidAutoBack = false

    /// 进度条
    open lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = progressTintColor
        progressView.trackTintColor = progressBGColor
        return progressView
    }()

    /// webView
    open lazy var webview: WKWebView = {
        let config = WKWebViewConfiguration()
        if msgs.isEmpty == false {
            let preference = WKPreferences()
            preference.javaScriptCanOpenWindowsAutomatically = true
            preference.javaScriptEnabled = true
            config.preferences = preference
            msgs.forEach {
                config.userContentController.add(self, name: $0)
            }
        }

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.backgroundColor = .white
        webview.scrollView.showsVerticalScrollIndicator = false
        webview.scrollView.showsHorizontalScrollIndicator = false
        webview.navigationDelegate = self
        webview.uiDelegate = self
        return webview
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        hasShowWeb = true
        configureUI()
        sc_navigationBar?.title = initialTitle
        loadUrl()
    }

    open func loadUrl() {
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData)
        webview.load(urlRequest)
    }

    open func handMsg(name: String, body: Any?) {
        // void impementation
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == __progressKP {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webview.estimatedProgress), animated: true)
            if webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.2,
                               delay: 0.1,
                               options: UIView.AnimationOptions.curveLinear,
                               animations: {
                                   self.progressView.alpha = 0
                               }) { _ in
                    self.progressView.setProgress(0.0, animated: false)
                }
            }
        } else if keyPath == __canGoBackKP {
            if isForbidAutoBack {
                return
            }
            if let newValue = change?[NSKeyValueChangeKey.newKey] as? Bool {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = !newValue
            } else {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
        }
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isForbidAutoBack {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isForbidAutoBack {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func actionBack() {
        if msgs.isEmpty == false {
            msgs.forEach {
                webview.configuration.userContentController.removeScriptMessageHandler(forName: $0)
            }
        }
        super.actionBack()
    }

    deinit {
        if hasShowWeb {
            webview.uiDelegate = nil
            webview.navigationDelegate = nil
            webview.removeObserver(self, forKeyPath: __progressKP)
            webview.removeObserver(self, forKeyPath: __canGoBackKP)
        }
    }
}

extension SCWebviewController: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let name = message.name
        let body = message.body
        handMsg(name: name, body: body)
    }
}

extension SCWebviewController {
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
            if let bar = self.sc_navigationBar {
                $0.top.equalTo(bar.snp.bottom)
            } else {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            }
        }

        view.addSubview(webview)
        webview.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(progressView.snp.bottom)
        }

        webview.addObserver(self, forKeyPath: __canGoBackKP, options: .new, context: nil)
        webview.addObserver(self, forKeyPath: __progressKP, options: .new, context: nil)
    }
}

extension SCWebviewController: WKUIDelegate, WKNavigationDelegate {
    // MARK: - WKNavigationDelegate

    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let webTitle = webView.title,
           webTitle.isEmpty == false {
            sc_navigationBar?.title = webTitle
        } else {
            sc_navigationBar?.title = initialTitle
        }
    }
}
