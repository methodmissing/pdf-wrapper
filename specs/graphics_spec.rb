# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

context "The PDF::Wrapper class" do
  specify "should be able to draw a single line onto the canvas" do
    x0 = y0 = 100
    x1 = y1 = 200
    pdf = PDF::Wrapper.new
    pdf.line(x0,y0,x1,y1)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # the begin_new_subpath command specifies the start of the line, append line specifies the end
    receiver.count(:begin_new_subpath).should eql(1)
    receiver.count(:append_line).should eql(1)
    receiver.first_occurance_of(:begin_new_subpath)[:args].should eql([x0.to_f, 741.89])
    receiver.first_occurance_of(:append_line)[:args].should eql([x1.to_f, 641.89])
  end

  specify "should be able to draw a single line onto the canvas with a width of 5" do
    x0 = y0 = 100
    x1 = y1 = 200
    width = 5
    pdf = PDF::Wrapper.new
    pdf.line(x0,y0,x1,y1, :line_width => width)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # the begin_new_subpath command specifies the start of the line, append line specifies the end
    receiver.count(:set_line_width).should eql(1)
    receiver.count(:begin_new_subpath).should eql(1)
    receiver.count(:append_line).should eql(1)
    receiver.first_occurance_of(:set_line_width)[:args].should eql([width.to_f])
    receiver.first_occurance_of(:begin_new_subpath)[:args].should eql([x0.to_f, 741.89])
    receiver.first_occurance_of(:append_line)[:args].should eql([x1.to_f, 641.89])
  end

  specify "should be able to draw a cubic bezier spline onto the canvas"

  specify "should be able to draw an empty rectangle onto the canvas" do
    x = y = 100
    w = h = 200
    pdf = PDF::Wrapper.new
    pdf.rectangle(x,y,w,h)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # the begin_new_subpath command specifies the start of the line, append line specifies the end
    callbacks = receiver.all(:append_rectangle)
    callbacks.size.should eql(2)
    # don't care about the first rectangel, it just goes around the outside of the page
    callbacks.shift
    callbacks.shift[:args].should eql([100.0, 741.89, 200.0, -200.0])
  end

  specify "should be able to draw an empty rectangle onto the canvas with a line width of 5" do
    x = y = 100
    w = h = 200
    width = 5
    pdf = PDF::Wrapper.new
    pdf.rectangle(x,y,w,h, :line_width => width)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # ensure the line width was set correctly
    receiver.count(:set_line_width).should eql(1)
    receiver.first_occurance_of(:set_line_width)[:args].should eql([width.to_f])

    # the begin_new_subpath command specifies the start of the line, append line specifies the end
    callbacks = receiver.all(:append_rectangle)
    callbacks.size.should eql(2)
    # don't care about the first rectangel, it just goes around the outside of the page
    callbacks.shift
    callbacks.shift[:args].should eql([100.0, 741.89, 200.0, -200.0])
  end

  specify "should be able to draw a filled rectangle onto the canvas"
=begin
  do
    x = y = 100
    w = h = 200
    pdf = PDF::Wrapper.new
    pdf.rectangle(x,y,w,h, :fill_color => :red)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # TODO: test for the appropriate pattern of callbacks
  end
=end

  specify "should be able to draw an empty rounded rectangle onto the canvas"
=begin
  do
    x = y = 100
    w = h = 200
    r = 5
    pdf = PDF::Wrapper.new
    pdf.rectangle(x,y,w,h,:radius => r)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # TODO: test for the appropriate pattern of callbacks
  end
=end

  specify "should be able to draw an empty rounded rectangle onto the canvas with a line width of 5"
=begin
  do
    x = y = 100
    w = h = 200
    r = 5
    w = 5
    pdf = PDF::Wrapper.new
    pdf.rounded_rectangle(x,y,w,h, :radius => r, :line_width => w)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # TODO: test for the appropriate pattern of callbacks
  end
=end

  specify "should be able to draw a filled rounded rectangle onto the canvas"
=begin
  do
    x = y = 100
    w = h = 200
    r = 5
    pdf = PDF::Wrapper.new
    pdf.rounded_rectangle(x,y,w,h, :radius => r, :fill_color => :red)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # TODO: test for the appropriate pattern of callbacks
  end
=end

  specify "should be able to draw an empty circle onto the canvas"
=begin
  do
    x = 100
    y = 200
    r = 5
    pdf = PDF::Wrapper.new
    pdf.circle(x,y,r)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # TODO: test for the appropriate pattern of callbacks
  end
=end

  specify "should be able to draw an empty circle onto the canvas with a line width of 5"
=begin
  do
    x = 100
    y = 200
    r = 5
    w = 5
    pdf = PDF::Wrapper.new
    pdf.circle(x,y,r, :line_width => w)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # TODO: test for the appropriate pattern of callbacks
  end
=end

  specify "should be able to draw a filled circle onto the canvas"
=begin
  do
    x = 100
    y = 200
    r = 5
    pdf = PDF::Wrapper.new
    pdf.circle(x,y,r, :fill_color => :red)

    receiver = PDF::Reader::RegisterReceiver.new
    reader = PDF::Reader.string(pdf.render, receiver)

    # TODO: test for the appropriate pattern of callbacks
  end
=end
end
