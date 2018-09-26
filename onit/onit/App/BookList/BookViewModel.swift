struct BookViewModel {
    let title: String
    let subtitle: String
    let thumbnail: String
    let extendedDescripion: String
}

extension BookViewModel {
    init(remote: GoogleBookRemote) {
        self.title = remote.volumeInfo.title
        self.subtitle = remote.volumeInfo.subtitle ?? ""
        self.thumbnail = remote.volumeInfo.imageLinks?.smallThumbnail ?? ""
        self.extendedDescripion = remote.volumeInfo.description ?? "Description not available"
    }
}
