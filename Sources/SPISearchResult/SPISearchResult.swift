#if os(Linux)
    @preconcurrency import struct Foundation.Data
    @preconcurrency import struct Foundation.Date
    @preconcurrency import struct Foundation.URL
#else
    import struct Foundation.Data
    import struct Foundation.Date
    import struct Foundation.URL
#endif

public struct PackageId: Codable {
    public let owner: String
    public let repository: String

    public init(owner: String, repository: String) {
        self.owner = owner
        self.repository = repository
    }

    enum CodingKeys: String, CodingKey {
        case owner = "o"
        case repository = "r"
    }
}

public struct SearchResultPackage: Codable {
    public let id: PackageId
    public let keywords_matched: [String]
    public let summary: String?
    public let stars: Int

    public init(id: PackageId, keywords_matched: [String], summary: String?, stars: Int) {
        self.id = id
        self.keywords_matched = keywords_matched
        self.summary = summary
        self.stars = stars
    }

    enum CodingKeys: String, CodingKey {
        case id
        case keywords_matched = "k"
        case summary = "s"
        case stars = "x"
    }
}

public struct SearchResult: Codable {
    public let timestamp: Date
    public let query: String
    public let keywords: [String]
    public let packages: [SearchResultPackage]

    public init(timestamp: Date, query: String, keywords: [String], packages: [SearchResultPackage]) {
        self.timestamp = timestamp
        self.query = query
        self.keywords = keywords
        self.packages = packages
    }

    enum CodingKeys: String, CodingKey {
        case timestamp = "t"
        case query = "q"
        case keywords = "k"
        case packages = "p"
    }
}
