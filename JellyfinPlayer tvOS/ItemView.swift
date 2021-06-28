/* JellyfinPlayer/Swiftfin is subject to the terms of the Mozilla Public
 * License, v2.0. If a copy of the MPL was not distributed with this
 * file, you can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * Copyright 2021 Aiden Vigue & Jellyfin Contributors
 */

import SwiftUI
import Introspect
import JellyfinAPI

class VideoPlayerItem: ObservableObject {
    @Published var shouldShowPlayer: Bool = false
    @Published var itemToPlay: BaseItemDto = BaseItemDto()
}

struct ItemView: View {
    private var item: BaseItemDto

    @StateObject private var videoPlayerItem: VideoPlayerItem = VideoPlayerItem()
    @State private var videoIsLoading: Bool = false; // This variable is only changed by the underlying VLC view.
    @State private var isLoading: Bool = false
    @State private var viewDidLoad: Bool = false

    init(item: BaseItemDto) {
        self.item = item
    }

    var body: some View {
        ZStack {
            NavigationLink(destination: VideoPlayerView(item: videoPlayerItem.itemToPlay), isActive: $videoPlayerItem.shouldShowPlayer) {
                EmptyView()
            }
            .buttonStyle(PlainNavigationLinkButtonStyle())
            .focusable(false)
            
            Group {
                if item.type == "Movie" {
                    MovieItemView(item: item)
                } else {
                    Text("Type: \(item.type ?? "") not implemented yet :(")
                }
            }
            .environmentObject(videoPlayerItem)
        }
    }
}
