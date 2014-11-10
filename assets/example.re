#@# 章のリード文
//lead{
Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.
//}

#@# 見出し
= 章
== 節
=== 項
==== 段
===== 小段

#@# インライン要素
@<b>{bold}
@<i>{italic}
@<strong>{strong}
@<em>{em}
@<kw>{keyword}
@<chap>{chapter}
@<title>{title}
@<chapref>{chapref}
@<ruby>{base, text}
@<ami>{ami}
@<code>{p = obj.ref_cnt}
@<href>{www.google.com/}
@<href>{www.google.com/, Google検索ページ}
@<img>{imgsample}

#@# ブロック要素
===[column] title
colomn body
colomn body
colomn body
===[/column]

#@# リスト
//list[list][リストのサンプル]{
int main(int argc, char **argv) {
  puts("OK");
  return 0;
}
//}

//emlist{
printf("hello");
//}

//source[/sample/sample.rb]{
def hogehoge
  puts "Hello, world!"
end
//}

//listnum[listnum][番号付きリストのサンプル]{
int main(int argc, char **argv) {
  puts("OK");
  return 0;
}
//}

#@# 箇条書きリスト
 * 1つ目
 * 2つ目
 * 3つ目
 ** ネスト1つ目
 ** ネスト2つ目

#@# 連番リスト
 1. 1つ目
 2. 2つ目
 3. 3つ目

#@# 説明付きリスト
: Alpha
  DEC の作っていた RISC CPU。
: POWER
  IBM とモトローラが共同製作した RISC CPU。
  派生として POWER PC がある。
: SPARC
  Sun が作っている RISC CPU。
  CPU 数を増やすのが得意。




 [EOF]
