# I18N.SITE · Language Without Borders<img Src="//ok0.pw/5l" Style="float:right;width:42px;margin-Top:6px">

I18N.SITE, a multi-language static site generator, can automatically translate Markdown into [more than a hundred different languages](https://github.com/i18n-site/node/blob/main/lang/src/index.js) .

<img src="http://s-cd-3653-i18n-img.oss.dogecdn.com/i18n.lang.webp" alt="" />

Some people may want to ask, now that browsers have built-in translation functions, is it unnecessary to internationalize the website?

I want to say that **only by internationalizing the entire site can we support multi-lingual in-site full-text search and search engine optimization** .

## Tutorial

## Function Introduction

### Keep Markdown Format

### Modify Translation

After modifying the translation, you need to re-run `./i18n.sh` to update the cache.

### Translation Notes

Translation comments need to indicate the language after \```, such as ` ```rust` .

Currently supports comment translation for rust, c, cpp, java, js, coffee, python, and bash.

Edit [tran_md/src/comment.coffee](https://github.com/i18n-site/node/blob/main/tran_md/src/comment.coffee) to add translation support for comments in more languages.

### Configure Proxy

Setting the following environment variables allows Google Translate API calls to go through the proxy.

```bash
export https_proxy=http://127.0.0.1:7890
```

### Variable Embedding

```
test: 测试变量<br 0>嵌入
```

### Empty The Cache

```bash
rm -rf .i18n/.cache
```

> Quote 1
>
> Quote 2

[toc]
