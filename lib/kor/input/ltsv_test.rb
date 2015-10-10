require 'kor/input/ltsv'

module KorInputLtsvTest
  def test_command(t)
    ltsv = <<-LTSV
foo:100\tbar:200\tbaz:qux:300
\tbar:500\tfoo:600
foo:110\tbar:120\tbaz:130
foo:140\tbar:150\tbaz:160
foo:170\tbar:180\tbaz:190
foo:200\tbar:210\tbaz:220
LTSV

    actual = `echo '#{ltsv.chomp}' | kor ltsv csv`
    expect = <<-CSV
foo,bar,baz
100,200,qux:300
600,500,
110,120,130
140,150,160
170,180,190
200,210,220
CSV
    if actual != expect
      t.error("expect #{expect} got #{actual}")
    end

    actual = `echo '#{ltsv.chomp}' | kor ltsv --guess-time=100 csv`
    if actual != expect
      t.error("expect #{expect} got #{actual}")
    end

    actual = `echo '#{ltsv.chomp}' | kor ltsv --guess-time=0 csv`
    if actual != expect
      t.error("expect #{expect} got #{actual}")
    end

    actual = `echo '#{ltsv.chomp}' | kor ltsv --key=bar,foo,non csv`
    expect = <<-CSV
bar,foo,non
200,100,
500,600,
120,110,
150,140,
180,170,
210,200,
CSV
    if actual != expect
      t.error("expect #{expect} got #{actual}")
    end
  end
end
