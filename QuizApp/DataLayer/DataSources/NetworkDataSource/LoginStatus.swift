enum LoginStatus {

    case success
    case error(Int, String)
    
    private var comparisonValue: String {
        switch self {
        case .success:
            return "success"
        case .error(_, _):
            return "error"
        }
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.comparisonValue == rhs.comparisonValue
    }

}
