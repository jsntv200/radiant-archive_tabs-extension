# Archive Tabs

Display Archive pages in their own paginated tab.

Archive page types often contain the most child pages, with Radiant's tree based navigation this can often lead to very long lists. Archive tabs creates a tab for each Archive Page Type which contains a paginated list of it's children.

Archive pages will no longer display their children on the main Pages index page.

Tested against Radiant v1.0.0 and probably won't be back ported to older versions

It's a monkey patch so use at your own risk.


## Installation

Install as a gem :

```
gem install radiant-archive_tabs-extension
```

Ensure Archive Tabs is loaded last :

```
config.extensions = [ :all, :archive_tabs ]
```

Load Archive Tabs by adding the gem :

```
config.gem 'radiant-archive_tabs-extension', :version => '1.0.0'
```


## To Do

- Add search filter ?
- Look into why will_paginate isn't creating the correct urls, currently using a js hack to fix this
