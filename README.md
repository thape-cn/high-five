# High Five 🙌

[![Build Status](https://github.com/thape-cn/high-five/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/thape-cn/high-five/actions)

## How to import DB

```bash
psql -d postgres
DROP DATABASE highfive_development;
CREATE DATABASE highfive_development WITH ENCODING='UTF8';
\q
psql -d highfive_development -f high_five_prod_db.sql
```

## Development notes

### When you want to debug the SCSS

Set `shakapacker.yml` hmr to true.

```yml
hmr: true
```

### Why should always include "stimulus"

Because using webpack 5, the loading sequence do matter.

### How to debug in VSCode?

Install `Ruby LSP` by Shopify and `VSCode rdbg Ruby Debugger` by KoichiSasada.

Make sure debug only having one version install as default gems, otherwise uninstall first:

```bash
gem uninstall -i /opt/homebrew/Cellar/ruby/3.2.2/lib/ruby/gems/3.2.0 debug
gem install debug --default
```
