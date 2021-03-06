import UIKit

protocol Reusable: AnyObject {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String { String(describing: Self.self) }
}

extension UITableView {
    func register<Cell: Reusable>(cell: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.identifier)
    }
    
    func dequeueCell<Cell: Reusable>(for indexPath: IndexPath, type: Cell.Type = Cell.self) -> Cell {
        guard let reusableCell = dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("""
                Failed to dequeue cell of type '\(type)' with identifier '\(Cell.identifier)' for
                indexPath '\(indexPath)' on tableView \(self). Make sure you registered the cell
                before dequeueing.
                """)
        }
        
        return reusableCell
    }
    
    func register<HeaderFooter: Reusable>(headerFooter: HeaderFooter.Type) {
        register(HeaderFooter.self, forHeaderFooterViewReuseIdentifier: HeaderFooter.identifier)
    }
    
    func dequeueHeaderFooter<HeaderFooter: Reusable>(type: HeaderFooter.Type = HeaderFooter.self) -> HeaderFooter {
        guard let reusableHeaderFooter = dequeueReusableHeaderFooterView(withIdentifier: HeaderFooter.identifier) as? HeaderFooter else {
            fatalError("""
                Failed to dequeue header/footer of type '\(type)' with identifier '\(HeaderFooter.identifier)'
                for on tableView \(self). Make sure you registered the header/footer before dequeueing.
                """)
        }
        
        return reusableHeaderFooter
    }
}
