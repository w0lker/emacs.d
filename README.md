# Emacs配置
本配置只能保证在MacOSX下使用正常，代码只做了少量的兼容处理，Windows或者Linux使用需谨慎。

主要提供对Go、C++和Python的开发环境的支持。

## 目录
	init.el 启动入口
	lisp 代码
	conf 非代码的配置文件
	temp 临时生成的文件，项目初始化后会创建

## 使用
	git clone https://github.com/w0lker/emacs.d.git ~/.emacs.d

## 注意
1. 如果使用C++主模式，则需要安装rtags，否则无法通过代码补全功能。

		# 安装
		brew install rtags --HEAD
		# 添加开机自启动
		brew service start rtags
	
