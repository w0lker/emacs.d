# Emacs配置
项目的原则是简单，所以我现在添加库的原则是能不引用库就不会引用，使用尽量少的配置来完成要做的事情。

只能保证在MacOSX下使用正常，代码只做了少量的兼容处理，Windows或者Linux使用需谨慎。

## 目录
* init.el 启动入口
* lisp 代码
* conf 非代码的配置文件
* temp 临时生成的文件，项目初始化后会创建

## 安装
```
git clone https://github.com/w0lker/emacs.d.git ~/.emacs.d
```

## 开发环境
主要提供了对Go、C++和Python开发环境的支持。

### Markdown模式
如果要支持导出功能，需要本地安装markdown这个工具。
```
brew install markdown
```

### C++模式
本地需要安装rtags服务，否则无法使用代码补全功能。
```
brew install rtags --HEAD
# 添加开机自启动
brew service start rtags
```

### Python模式
使用自动补全，没有安装jedi这些自动补全工具，使用了最简单的ipython的自动补全

1. 使用`C-c C-p` 打开ipython的shell;
2. 导入当前代码`C-c C-c`, 这个时候就可以使用自动补全。
