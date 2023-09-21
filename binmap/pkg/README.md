<!-- 本文件由 ./readme.make.md 自动生成，请不要直接修改此文件 -->

# @rmw/utf8

wasm wrapper for wasm

see https://lib.rs/crates/wasm


## wasm

Short text compression algorithm for utf-8 (optimized for Chinese , developed based on rust programming language).

面向utf-8的短文本压缩算法（为中文压缩优化，基于rust编程语言开发）。



##  安装

```
yarn add @rmw/utf8
```

或者

```
npm install @rmw/utf8
```

## 使用

```
#!/usr/bin/env coffee

import {encode, encode_bin, decode} from './pkg'

t = encode 'test'
console.log t
console.log decode t

t = encode_bin Buffer.from('test')
console.log t
console.log decode t
```

## 关于

本项目隶属于**人民网络([rmw.link](//rmw.link))** 代码计划。

![人民网络](https://raw.githubusercontent.com/rmw-link/logo/master/rmw.red.bg.svg)
