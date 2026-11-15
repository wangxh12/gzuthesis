# 清华模板示例预览

已在 TeX Live 2026 / WSL Ubuntu 下编译本项目附带的 ThuThesis 7.7.1 硕士示例。

- PDF：`build/thuthesis/thuthesis-example.pdf`，34 页 A4。
- 保留原示例的 `degree=master`、学术学位及 `output=print`，含双面打印用的空白页。
- 原 `thuthesis.dtx`、`thuthesis-example.tex`、`thusetup.tex` 和示例章节均未改动。
- 新增 `thuthesis/thuthesis-preview.tex` 包装入口，只调整本机字体查找：中文直接使用现有 Windows 宋体、黑体、楷体、仿宋文件，西文字体沿用 fandol 配置对应的字体，数学字体沿用示例的 XITS。
- 缺失宏包安装在项目的 `build/thuthesis-texmf/` 用户树，未修改系统 TeX Live 安装；字体文件未复制到项目。
- 最终编译日志没有缺字、未定义引用或溢出盒；已查看封面和代表性正文页面。

从项目根目录重新生成：

```bash
bash utils/build-thuthesis.sh
```

若清理了本地依赖目录，先恢复依赖：

```bash
bash utils/build-thuthesis.sh --install-deps
```

该脚本用于当前 WSL/TeX Live 环境的比较预览。其他机器仍需具备基础 CTeX、fontspec 和 TeX Live 工具；没有 Windows 字体文件时回退到 Fandol，示例中的生僻字可能缺字。
