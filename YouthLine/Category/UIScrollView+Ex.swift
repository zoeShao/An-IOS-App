import Foundation
import MJRefresh

extension UIScrollView {
    open func initRefreshView() {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        self.mj_header = header
        
        let footer = MJRefreshBackNormalFooter()
        footer.stateLabel.isHidden = true
        self.mj_footer = footer
    }
}
