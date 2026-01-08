;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ECOSYSTEM.scm - Project ecosystem positioning

(ecosystem
  (version "1.0.0")
  (name "asdf-varnish-plugin")
  (type "asdf-plugin")
  (purpose "Version management for Varnish HTTP cache")

  (position-in-ecosystem
    (category "developer-tools")
    (subcategory "version-management")
    (layer "user-facing"))

  (related-projects
    (sibling-standard
      (name "asdf")
      (relationship "plugin-host")
      (url "https://asdf-vm.com"))
    (sibling-standard
      (name "varnish")
      (relationship "managed-tool")
      (url "https://varnish-cache.org/")))

  (what-this-is
    "An asdf plugin for managing Varnish HTTP cache versions")

  (what-this-is-not
    "Not a standalone version manager"
    "Not a replacement for the tool itself"))
