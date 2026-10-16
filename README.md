# 暨南大学本科实验报告 · Typst 模板

用 [Typst](https://typst.app/) 排版暨南大学本科实验报告（封面表单 + 附页正文）。
纯标准库实现，**不依赖任何第三方包**。

版式参数来自对源文件 `jnu-report.doc`（Word 97-2003）的解析，并与转换出的
`jun-report.pdf` 的坐标逐项比对：A4、页边距上下 2.54cm / 左右 3.17cm、
封面 6 行字段、填空处细下划线等。

## 文件结构

```
.
├── lib.typ     # 模板样式库：字体栈、辅助函数、jnu-report(..) 主模板
├── main.typ    # 文档入口：填封面字段 + 写正文
└── README.md
```

## 环境要求

- Typst（开发验证于 0.15.1，建议使用较新版本）。
- 中文字体。模板内置字体回退，缺少某些字体只会产生
  `unknown font family` 警告，不影响编译。

## 快速开始

`main.typ` 就是一个可直接编辑的示例。最简骨架：

```typst
#import "lib.typ": jnu-report

#show: jnu-report.with(
  course: "模拟电子技术实验",
  lab-name: "晶体管共射极单管放大器",
  instructor: "李四",
  author: "张三",
  student-id: "2020101234",
  year: "2026", month: "10", day: "16", ampm: "上",
  end-month: "10", end-day: "16", end-ampm: "下",
)

= 实验目的

这里是正文……

== 实验原理

……
```

编译：

```sh
typst compile main.typ        # 生成 main.pdf
typst watch main.typ          # 保存即自动重新编译
typst compile --font-path ... main.typ   # 需要时指定额外字体目录
```

## 正文写法

`#show: jnu-report.with(...)` 之后的普通 Typst 内容即正文，模板已预设好：

- 正文：五号（10.5pt）、1.5 倍行距、首行缩进 2 字符、两端对齐。
- 标题自动编号：
  - `= 标题` → 一级：`一、标题`
  - `== 标题` → 二级：`（一）标题`
  - `=== 标题` → 三级：`1. 标题`
  - `==== 标题` 及以下：仅加粗、不编号
- 表格、公式、列表等直接用 Typst 原生语法，例如：

```typst
#table(
  columns: (auto, auto, auto),
  align: (center, center, center),
  stroke: 0.5pt,
  [测量项], [$U_o"/V"$], [$I_C"/mA"$],
  [理论值], [1.20], [1.50],
)
```

## 参数说明

所有参数都通过 `jnu-report.with(...)` 传入，均可省略（省略即用默认值）。

### 封面字段

| 参数 | 含义 |
| --- | --- |
| `course` | 课程名称 |
| `grade` | 成绩评定 |
| `lab-name` | 实验项目名称 |
| `instructor` | 指导教师 |
| `lab-id` | 实验项目编号 |
| `lab-type` | 实验项目类型 |
| `site` | 实验地点 |
| `author` | 学生姓名 |
| `student-id` | 学号 |
| `college` | 学院 |
| `department` | 系 |
| `major` | 专业 |

### 实验时间

表单结构为 `__年__月__日__午 ～ __月__日__午 温度__℃ 湿度__`。

| 参数 | 含义 |
| --- | --- |
| `year` / `month` / `day` / `ampm` | 起始 年 / 月 / 日 / 午（上午填「上」、下午填「下」） |
| `end-month` / `end-day` / `end-ampm` | 结束 月 / 日 / 午 |
| `temperature` | 温度（单位 ℃ 已印在表单上） |
| `humidity` | 湿度 |

### 标题与报头

| 参数 | 默认值 | 含义 |
| --- | --- | --- |
| `title` | `"暨南大学本科实验报告专用纸"` | 封面标题 |
| `appendix-title` | `"暨南大学本科实验报告专用纸"` | 附页报头主标题 |
| `appendix-suffix` | `"(附页)"` | 报头后缀 |
| `show-appendix-header` | `true` | 是否显示附页报头 |
| `show-header-rule` | `true` | 报头标题下是否画横线 |

### 版式

| 参数 | 默认值 | 含义 |
| --- | --- | --- |
| `paper` | `"a4"` | 纸张 |
| `margin-top` / `margin-bottom` | `2.54cm` | 上下页边距 |
| `margin-x` | `3.17cm` | 左右页边距 |
| `title-size` | `22pt` | 封面标题字号（二号） |
| `title-weight` | `"bold"` | 封面标题字重 |
| `field-size` | `12pt` | 封面字段字号 |
| `label-weight` | `"bold"` | 封面标签（课程名称等）字重 |
| `value-align` | `center` | 填空值对齐：`center` / `left` / `right` |
| `blank-rule` | `true` | 是否给填空画下划线 |
| `cover-top` | `-38pt` | 封面标题相对页顶的额外留白（可为负） |
| `cover-gap` | `16.5pt` | 封面标题与字段区之间的间距 |
| `cover-leading` | `0em` | 封面字段行距 |
| `row-pitch` | `21pt` | 字段行距（相邻下划线之间的距离） |
| `appendix-size` | `18pt` | 附页报头主标题字号 |
| `appendix-suffix-size` | `16pt` | `"(附页)"` 字号 |
| `header-title-dy` | `30pt` | 报头标题距页面顶边的偏移 |
| `header-rule-y` | `52pt` | 报头横线距页面顶边的位置 |
| `body-new-page` | `false` | 正文是否另起一页 |
| `cover-body-gap` | `1em` | 正文接在封面后时与封面之间的间距 |
| `body-size` | `10.5pt` | 正文字号（五号） |
| `h1-size` / `h2-size` / `h3-size` | `12pt` / `10.5pt` / `10.5pt` | 各级标题字号 |
| `leading` | `1.5em` | 正文行距 |
| `spacing` | `0.8em` | 段落间距 |
| `first-line-indent` | `2em` | 首行缩进 |
| `justify` | `true` | 是否两端对齐 |

## 版式行为说明

- **正文位置**：默认紧接封面之后，**从第 1 页开始**。若要让正文另起一页，
  设置 `body-new-page: true`。
- **附页报头**：「……(附页)」标题与横线**只在第 2 页起出现**，第 1 页
  （封面所在页）不显示。其实现方式是「按页码判断的页眉」。
- **报头位置**：各页边距统一，报头必须落在上边距（`margin-top`）以内。
  默认 `header-rule-y: 52pt` 小于 `margin-top`（72pt），安全；若把
  `header-rule-y` 调到大于上边距，横线会压到正文上。
- **字体回退**：模板优先使用 `Times New Roman` + 中文宋体/楷体；系统缺失时
  逐字形回退到 `Liberation Serif` / `Noto Serif CJK SC` / `LXGW WenKai` 等。
  若你的系统有其他可用字体，可修改 `lib.typ` 顶部的 `jnu-font-song` /
  `jnu-font-kai` / `jnu-font-hei` 字体栈。

## 给进阶用户

`lib.typ` 也导出了若干可复用的部件：

- 字体栈：`jnu-font-song`、`jnu-font-kai`、`jnu-font-hei`
- 单元格/行：`jnu-label`、`jnu-val`、`jnu-slot`、`jnu-field-row`
- 工具：`jnu-cn`（中文数字）、`jnu-sec` / `jnu-sub`（标题计数器）

例如只想用封面单页、不要正文模板：

```typst
#import "lib.typ": jnu-report
#show: jnu-report.with(course: "XX", lab-name: "XX")
```

## 说明

- 仓库中的 `jnu-report.doc`、`jun-report.pdf` 为版式参考来源，
  已在 `.gitignore` 中忽略，不纳入版本管理。
- 本项目仅使用 Typst 标准库，不引入任何外部包或模板。
