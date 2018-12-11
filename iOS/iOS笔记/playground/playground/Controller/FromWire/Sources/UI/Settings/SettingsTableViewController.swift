//
//  SettingsTableViewController.swift
//  playground
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class SettingsBaseTableViewController: UIViewController {
    var tableView: UITableView
    
    private let footerContainer = UIView()
    
    public var footer: UIView? {
        didSet {
            updateFooter(footer)
        }
    }
    
    // Intrinsic 固有
    final fileprivate class IntrinsicSizeTableView: UITableView {
        override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: UIViewNoIntrinsicMetric, height: self.contentSize.height)
            }
        }
    }
    
    init(style: UITableView.Style) {
        tableView = IntrinsicSizeTableView.init(frame: .zero, style: style)
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTableView()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    private func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 56
        view.addSubview(tableView)
        view.addSubview(footerContainer)
    }
    
    private func updateFooter(_ newFooter: UIView?) {
        footer?.removeFromSuperview()
        guard let newFooter = newFooter else { return }
        footerContainer.addSubview(newFooter)
        footerContainer.snp.makeConstraints {
            $0.edges.equalTo(footerContainer)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SettingsBaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        fatalError("Subclasses need to implement this method")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Subclasses need to implement this method")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Subclasses need to implement this method")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}

class SettingsTableViewController: SettingsBaseTableViewController {
    
    let group: SettingsInternalGroupCellDescriptorType
    
    required init(group: SettingsInternalGroupCellDescriptorType) {
        self.group = group
        super.init(style: group.style == .plain ? .plain : .grouped)
        self.title = group.title
        self.group.items.flatMap { return $0.cellDescriptors }.forEach {
            if let groupDescriptor = $0 as? SettingsGroupCellDescriptorType {
                groupDescriptor.viewController = self
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    func setupTableView() {

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        let allCellTypes: [SettingsTableCell.Type] = [SettingsTableCell.self, SettingsTextCell.self]
        
        for cellClass in allCellTypes {
            tableView.register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
        }
    }
}

extension SettingsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.group.visibleItems.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionDescriptor = self.group.visibleItems[section]
        return sectionDescriptor.visibleCellDescriptors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secionDescriptor = self.group.visibleItems[indexPath.section]
        let cellDescriptor = secionDescriptor.cellDescriptors[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellDescriptor).cellType.reuseIdentifier, for: indexPath) as? SettingsTableCell {
            cell.descriptor = cellDescriptor
            cellDescriptor.featureCell(cell)
            return cell
        }
        fatalError()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secionDescriptor = self.group.visibleItems[indexPath.section]
        let property = secionDescriptor.cellDescriptors[indexPath.row]
        property.select(.none)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerFooterView = view as? UITableViewHeaderFooterView {
            headerFooterView.textLabel?.textColor = UIColor(white: 1, alpha: 0.4)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let headerFooterView = view as? UITableViewHeaderFooterView {
            headerFooterView.textLabel?.textColor = UIColor(white: 1, alpha: 0.4)
        }
    }
}
