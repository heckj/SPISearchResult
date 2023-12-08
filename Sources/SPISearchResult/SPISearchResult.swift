#if os(Linux)
    @preconcurrency import struct Foundation.Data
    @preconcurrency import struct Foundation.Date
    @preconcurrency import struct Foundation.URL
#else
    import struct Foundation.Data
    import struct Foundation.Date
    import struct Foundation.URL
#endif

/// A search result from Swift Package Index
public struct SearchResult: Hashable, Identifiable, Codable {
    /// An opaque identifier of the package.
    public var id: Int {
        hashValue
        // NOTE: This is only a reasonably stable value because a search-result
        // is a non-mutable item, so rather than using an additional UUID or
        // such, we can take advantage of the hash value as a stable identifier.
    }

    /// The time at which the search was invoked.
    public let timestamp: Date
    /// The combined query terms for the search.
    public let query: String
    /// The keywords matched by the query terms.
    public let keywords: [String]
    /// The authors matched by the query terms.
    public let authors: [String]
    /// The packages returned for the query terms.
    public let packages: [Package]

    /// Creates a new search result.
    /// - Parameters:
    ///   - timestamp: The time at which the search was invoked.
    ///   - query: A string of the query terms for the search.
    ///   - keywords: The keywords matched by the query terms.
    ///   - authors: The authors matched by the query terms.
    ///   - packages: The packages returned for the query terms.
    public init(timestamp: Date, query: String, keywords: [String], authors: [String], packages: [Package]) {
        self.timestamp = timestamp
        self.query = query
        self.keywords = keywords
        self.authors = authors
        self.packages = packages
    }

    enum CodingKeys: String, CodingKey {
        case timestamp = "t"
        case query = "q"
        case keywords = "k"
        case authors = "a"
        case packages = "p"
    }

    /// A package as returned by a Swift Package Index search result.
    public struct Package: Hashable, Identifiable, Codable {
        /// The swift package index identifier for the package.
        public let id: PackageId
        /// The name of the package
        public let name: String
        /// The keywords reported as matched for this package.
        public let package_keywords: [String]
        /// The summary description provided about the package.
        public let summary: String?
        /// The number of GitHub stars reported for the package.
        public let stars: Int

        /// Creates a new package entry for a search result.
        /// - Parameters:
        ///   - id: The package identifier.
        ///   - matching_keywords: The keywords that matched from the search
        ///   - summary: The summary about the package.
        ///   - stars: The number of GitHub stars for the package.
        public init(id: PackageId, name: String, package_keywords: [String], summary: String?, stars: Int) {
            self.id = id
            self.name = name
            self.package_keywords = package_keywords
            self.summary = summary
            self.stars = stars
        }

        enum CodingKeys: String, CodingKey {
            case id
            case name = "n"
            case package_keywords = "k"
            case summary = "s"
            case stars = "x"
        }

        /// A Swift Package Index package identifier
        public struct PackageId: Hashable, Comparable, Identifiable, Codable, CustomStringConvertible {
            /// A string that represents the owner of the package.
            public let owner: String
            /// A string that represents the repository the holds the package.
            public let repository: String

            public init(owner: String, repository: String) {
                self.owner = owner
                self.repository = repository
            }

            enum CodingKeys: String, CodingKey {
                case owner = "o"
                case repository = "r"
            }

            // MARK: PackageId Conformances

            /// A string description of the package identifier.
            public var description: String {
                "\(owner)/\(repository)"
            }

            /// The identifier of a swift package as a single string.
            public var id: String {
                description
            }

            /// Compares two package identifiers to provide a stable sorting order by owner first, then repository.
            /// - Parameters:
            ///   - lhs: The first package id to be compared.
            ///   - rhs: The second package id to be compared.
            /// - Returns: Returns a lexical comparison based of the values of first on owner, then repository.
            public static func < (lhs: SearchResult.Package.PackageId, rhs: SearchResult.Package.PackageId) -> Bool {
                if lhs.owner == rhs.owner {
                    return lhs.repository < rhs.repository
                } else {
                    return lhs.owner < rhs.owner
                }
            }
        }
    }
}
