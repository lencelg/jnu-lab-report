#let jnu-font-song = (
  "Times New Roman", "Liberation Serif",
  "Noto Serif CJK SC", "Source Han Serif SC", "Noto Sans CJK SC",
)
#let jnu-font-kai = (
  "Times New Roman", "Liberation Serif",
  "LXGW WenKai", "KaiTi", "楷体", "Noto Serif CJK SC",
)
#let jnu-font-hei = (
  "Times New Roman", "Liberation Sans",
  "Noto Sans CJK SC", "Source Han Sans CN",
)

#let jnu-rule = 0.68pt + black
#let jnu-nbsp = "\u{00A0}"

#let jnu-cn-nums = (
  "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
  "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
)

#let jnu-cn(n) = if n >= 1 and n <= jnu-cn-nums.len() {
  jnu-cn-nums.at(n - 1)
} else {
  str(n)
}

// 正文标题计数器
#let jnu-sec = counter("jnu-sec")
#let jnu-sub = counter("jnu-sub")

#let jnu-label(s) = table.cell(
  inset: 0pt,
  align: left + horizon,
)[#box[#s]]

#let jnu-val(s, align-val: center, rule: true) = table.cell(
  inset: (bottom: 3pt),
  stroke: if rule { (bottom: jnu-rule) } else { none },
  align: align-val + horizon,
)[#box[#if s == "" { jnu-nbsp } else { s }]]

#let jnu-slot(s, unit: none, w: 1cm, rule: true, align-val: center) = {
  box(
    width: w,
    stroke: if rule { (bottom: jnu-rule) } else { none },
    inset: (bottom: 3pt),
    align(align-val + horizon)[#if s == "" { jnu-nbsp } else { s }],
  )
  if unit != none { [#unit] }
}

#let jnu-field-row(columns, pitch: 21pt, ..cells) = block(
  width: 100%, height: pitch, above: 0pt, below: 0pt, inset: (bottom: 2pt),
  align(bottom + left, table(
    columns: columns, rows: auto, inset: 0pt, stroke: none,
    column-gutter: 0pt, align: horizon, ..cells,
  )),
)

#let jnu-report(
  course: "",
  grade: "",
  lab-name: "",
  instructor: "",
  lab-id: "",
  lab-type: "",
  site: "",
  author: "",
  student-id: "",
  college: "",
  department: "",
  major: "",

  year: "", month: "", day: "", ampm: "",
  end-month: "", end-day: "", end-ampm: "",
  temperature: "",
  humidity: "",

  // title and appendix
  title: "暨南大学本科实验报告专用纸",
  appendix-title: "暨南大学本科实验报告专用纸",
  appendix-suffix: "(附页)",
  show-appendix-header: true,
  show-header-rule: true,

  paper: "a4",
  margin-top: 2.54cm,
  margin-bottom: 2.54cm,
  margin-x: 3.17cm,

  title-size: 22pt,          // 封面标题：二号
  title-weight: "bold",
  field-size: 13pt,          // 封面字段：四号
  label-weight: "regular",   // 标签字重（源文档为常规）
  value-align: center,       // 填空值对齐：center / left / right
  blank-rule: true,          // 是否给填空画下划线
  cover-top: 14pt,           // 封面标题距页顶（在页边距之外再加的留白）
  cover-gap: 16.5pt,         // 标题与字段区之间的间距
  cover-leading: 0em,        // 封面字段行距（配合 row-pitch 控制）
  row-pitch: 21pt,           // 字段行距（相邻下划线之间的距离，源文档为 21pt）

  appendix-size: 18pt,       // 附页标题字号（与封面一致）
  appendix-suffix-size: 16pt,// “(附页)”字号：三号
  header-title-dy: 30pt,   // 附页标题（22pt）距页面顶边的放置偏移
  header-rule-y: 52pt,      // 附页标题下横线距页面顶边的位置
  body-margin-top: 70pt,    // 正文页上边距（需容纳附页“报头”）

  body-size: 10.5pt,         // 正文：五号
  h1-size: 12pt,             // 一级标题：小四
  h2-size: 10.5pt,
  h3-size: 10.5pt,
  leading: 1.5em,
  spacing: 0.8em,
  first-line-indent: 2em,
  justify: true,

  body,
) = {
  set document(title: title, author: author)
  set text(font: jnu-font-song, size: field-size, lang: "zh", region: "cn")

  set page(
    paper: paper,
    margin: (top: margin-top, bottom: margin-bottom, left: margin-x, right: margin-x),
    numbering: none,
  )

  set par(leading: cover-leading)
  v(cover-top)
  align(center)[
    #text(font: jnu-font-song, size: title-size, weight: title-weight)[#title]
  ]
  v(cover-gap)

  let field(columns, ..cells) = jnu-field-row(columns, pitch: row-pitch, ..cells)

  // ① 课程名称 · 成绩评定
  field((auto, 224fr, auto, 79.65fr),
    jnu-label("课程名称"), jnu-val(course, align-val: value-align, rule: blank-rule),
    jnu-label("成绩评定"), jnu-val(grade, align-val: value-align, rule: blank-rule),
  )

  // ② 实验项目名称 · 指导教师
  field((auto, 182fr, auto, 93.65fr),
    jnu-label("实验项目名称"), jnu-val(lab-name, align-val: value-align, rule: blank-rule),
    jnu-label("指导教师"), jnu-val(instructor, align-val: value-align, rule: blank-rule),
  )

  // ③ 实验项目编号 · 实验项目类型 · 实验地点
  field((auto, 91fr, auto, 28fr, auto, 72.65fr),
    jnu-label("实验项目编号"), jnu-val(lab-id, align-val: value-align, rule: blank-rule),
    jnu-label("实验项目类型"), jnu-val(lab-type, align-val: value-align, rule: blank-rule),
    jnu-label("实验地点"), jnu-val(site, align-val: value-align, rule: blank-rule),
  )

  // ④ 学生姓名 · 学号
  field((auto, 119fr, auto, 212.65fr),
    jnu-label("学生姓名"), jnu-val(author, align-val: value-align, rule: blank-rule),
    jnu-label("学号"), jnu-val(student-id, align-val: value-align, rule: blank-rule),
  )

  // ⑤ 学院 · 系 · 专业
  field((auto, 140fr, auto, 70fr, auto, 135.65fr),
    jnu-label("学院"), jnu-val(college, align-val: value-align, rule: blank-rule),
    jnu-label("系"), jnu-val(department, align-val: value-align, rule: blank-rule),
    jnu-label("专业"), jnu-val(major, align-val: value-align, rule: blank-rule),
  )

  // ⑥ 实验时间：__年__月__日__午 ～ __月__日__午  温度__℃ 湿度__
  block(
    width: 100%, height: row-pitch, above: 0pt, below: 0pt, inset: (bottom: 2pt),
    align(bottom + left, par(justify: false)[#text(weight: label-weight)[实验时间]#jnu-slot(year, unit: "年", w: 28pt, rule: blank-rule, align-val: value-align)#jnu-slot(month, unit: "月", w: 14pt, rule: blank-rule, align-val: value-align)#jnu-slot(day, unit: "日", w: 14pt, rule: blank-rule, align-val: value-align)#h(6pt)#jnu-slot(ampm, unit: "午～", w: 14pt, rule: blank-rule, align-val: value-align)#jnu-slot(end-month, unit: "月", w: 14pt, rule: blank-rule, align-val: value-align)#jnu-slot(end-day, unit: "日", w: 14pt, rule: blank-rule, align-val: value-align)#h(6pt)#jnu-slot(end-ampm, unit: "午", w: 14pt, rule: blank-rule, align-val: value-align)#h(6pt)温度#jnu-slot(temperature, w: 14pt, rule: blank-rule, align-val: value-align)℃湿度#jnu-slot(humidity, w: 30pt, rule: blank-rule, align-val: value-align)]),
  )

  //  第 2 页
  pagebreak()

  let appendix-header = align(top)[
    #place(top + center, dy: header-title-dy, block(width: 100%)[
      #text(font: jnu-font-song, size: appendix-size, weight: "bold")[#appendix-title]#text(font: jnu-font-song, size: appendix-suffix-size)[#appendix-suffix]
    ])
    #if show-header-rule {
      place(top, dy: header-rule-y, line(length: 100%, stroke: jnu-rule))
    }
  ]
  set page(
    margin: (top: body-margin-top, bottom: margin-bottom, left: margin-x, right: margin-x),
    header: if show-appendix-header { appendix-header } else { none },
  )

  if not show-appendix-header {
    // 无页眉时，在正文开头排一次附页标题
    align(center)[
      #text(font: jnu-font-song, size: appendix-size, weight: "bold")[#appendix-title]#text(font: jnu-font-song, size: appendix-suffix-size)[#appendix-suffix]
    ]
    v(1.0em)
  }

  // 正文
  set text(font: jnu-font-song, size: body-size, lang: "zh", region: "cn")
  set par(
    leading: leading,
    spacing: spacing,
    justify: justify,
    first-line-indent: first-line-indent,
  )

  // 计数器归零
  jnu-sec.update(0)
  jnu-sub.update(0)

  // 一级标题：一、二、……
  show heading.where(level: 1): it => {
    jnu-sec.step()
    jnu-sub.update(0)
    context {
      let n = jnu-sec.get().first()
      block(above: 1.3em, below: 0.7em, sticky: true, breakable: false)[
        #set text(font: jnu-font-song, size: h1-size, weight: "bold")
        #jnu-cn(n)、#it.body
      ]
    }
  }
  // 二级标题：（一）（二）……
  show heading.where(level: 2): it => {
    jnu-sub.step()
    context {
      let n = jnu-sub.get().first()
      block(above: 1.0em, below: 0.5em, sticky: true, breakable: false)[
        #set text(font: jnu-font-song, size: h2-size, weight: "bold")
        （#jnu-cn(n)）#it.body
      ]
    }
  }
  // 三级标题：1. 2. ……
  show heading.where(level: 3): it => block(
    above: 0.8em, below: 0.4em, sticky: true, breakable: false,
  )[
    #set text(font: jnu-font-song, size: h3-size, weight: "bold")
    #it.body
  ]

  // 四级及以下：仅加粗
  show heading.where(level: 4): it => block(above: 0.6em, below: 0.3em)[
    #set text(weight: "bold")
    #it.body
  ]

  body
}
