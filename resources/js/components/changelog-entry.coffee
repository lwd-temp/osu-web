# Copyright (c) ppy Pty Ltd <contact@ppy.sh>. Licensed under the GNU Affero General Public License v3.0.
# See the LICENCE file in the repository root for full licence text.

import StringWithComponent from 'components/string-with-component'
import UserLink from 'components/user-link'
import * as React from 'react'
import { div, span, a } from 'react-dom-factories'
import { trans } from 'utils/lang'
el = React.createElement

icon =
  add: 'fas fa-plus'
  fix: 'fas fa-check'
  misc: 'far fa-circle'

userLinkClass = 'changelog-entry__user-link'
userLink = (githubUser) ->
  if githubUser.osu_username?
    el UserLink,
      className: userLinkClass
      user:
        id: githubUser.user_id
        username: githubUser.osu_username
  else if githubUser.github_url?
    a
      className: userLinkClass
      href: githubUser.github_url
      githubUser.display_name
  else
    githubUser.display_name

export ChangelogEntry = ({entry}) =>
  titleHtml = _.escape(entry.title).replace(/(`+)([^`]+)\1/g, '<code>$2</code>')

  div
    className: 'changelog-entry'
    key: entry.id

    div className: 'changelog-entry__row',
      div className: "changelog-entry__title #{if entry.major then 'changelog-entry__title--major' else ''}",
        span className: 'changelog-entry__title-icon',
          span className: "changelog-entry__icon #{icon[entry.type]}"

        if entry.url?
          a
            href: entry.url
            className: 'changelog-entry__link'
            dangerouslySetInnerHTML:
              __html: titleHtml
        else
          span
            dangerouslySetInnerHTML:
              __html: titleHtml
        if entry.github_url?
          span null,
            ' ('
            a
              className: 'changelog-entry__link'
              href: entry.github_url
              "#{entry.repository.replace /^.*\//, ''}##{entry.github_pull_request_id}"
            ')'

        span
          className: 'changelog-entry__user'
          el StringWithComponent,
            mappings:
              user: userLink entry.github_user
            pattern: trans 'changelog.entry.by'

    if entry.message_html?
      div
        className: 'changelog-entry__row changelog-entry__row--message'
        dangerouslySetInnerHTML: __html: entry.message_html
