// Copyright 2022 The Brave Authors. All rights reserved.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import BraveCore

struct FilterList: Identifiable {
  /// The component ID of the "Fanboy's Mobile Notifications List"
  /// This is a special filter list that is enabled by default
  public static let mobileAnnoyancesComponentID = "bfpgedeaaibpoidldhjcknekahbikncb"
  /// The component id of the cookie consent notices filter list.
  /// This is a special filter list that has more accessible UI to control it
  public static let cookieConsentNoticesComponentID = "cdbbhgbmjhfnhnmgeddbliobbofkgdhe"
  /// A list of safe filter lists that can be automatically enabled if the user has the matching localization.
  /// - Note: These are regional fiter lists that are well maintained. For now we hardcode these values
  /// but it would be better if our component updater told us which ones are safe in the future.
  public static let maintainedRegionalComponentIDs = [
    "llgjaaddopeckcifdceaaadmemagkepi" // Japanese filter lists
  ]
  
  /// All the component ids that should be set to on by default.
  public static var defaultOnComponentIds: Set<String> {
    return [mobileAnnoyancesComponentID]
  }
  
  /// This is a list of component to UUID for some filter lists that have special toggles
  /// (which are availble before filter lists are downloaded)
  /// To save these values before filter lists are downloaded we need to also have the UUID
  public static var componentToUUID: [String: String] {
    return [
      mobileAnnoyancesComponentID: "2F3DCE16-A19A-493C-A88F-2E110FBD37D6",
      cookieConsentNoticesComponentID: "AC023D22-AE88-4060-A978-4FEEEC4221693"
    ]
  }
  
  let uuid: String
  let title: String
  let description: String
  let componentId: String
  let urlString: String
  var isEnabled: Bool = false
  let languages: [String]
  
  var id: String { return uuid }
  
  init(from filterList: AdblockFilterListCatalogEntry, isEnabled: Bool) {
    self.uuid = filterList.uuid
    self.title = filterList.title
    self.description = filterList.desc
    self.componentId = filterList.componentId
    self.isEnabled = isEnabled
    self.urlString = filterList.url
    self.languages = filterList.languages
  }
  
  func makeRuleType() -> ContentBlockerManager.BlocklistRuleType {
    return .filterList(uuid: uuid)
  }
}
