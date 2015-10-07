require 'kor/input/ltsv'

module KorInputLtsvTest
  def test_command(t)
    ltsv = <<-LTSV
foo:100\tbar:200\tbaz:qux:300
\tbar:500\tfoo:600
LTSV

    actual = `echo '#{ltsv.chomp}' | kor ltsv csv`
    expect = <<-CSV
foo,bar,baz
100,200,qux:300
600,500,
CSV
    if actual != expect
      t.error("expect #{expect} got #{actual}")
    end

    actual = `echo '#{ltsv.chomp}' | kor ltsv --keys=foo csv`
    expect = <<-CSV
foo
100
600
CSV
    if actual != expect
      t.error("expect #{expect} got #{actual}")
    end
  end
end
