/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation

/**
 Passed to openURL to indicate which default audience to use for sessions that post data to Facebook.

 Certain operations such as publishing a status or publishing a photo require an audience. When the user
 grants an application permission to perform a publish operation, a default audience is selected as the
 publication ceiling for the application. This enumerated value allows the application to select which
 audience to ask the user to grant publish permission for.
 */
@objc(FBSDKDefaultAudience)
public enum DefaultAudience: UInt {
  /// Indicates that the user's friends are able to see posts made by the application
  case friends
  /// Indicates that only the user is able to see posts made by the application
  case onlyMe
  /// Indicates that all Facebook users are able to see posts made by the application
  case everyone
}
