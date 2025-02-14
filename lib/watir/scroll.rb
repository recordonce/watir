module Watir
  module Scrolling
    def scroll
      Scroll.new(self)
    end
  end

  class Scroll
    def initialize(object)
      @object = object
    end

    # Scrolls by offset.
    # @param [Fixnum] left Horizontal offset
    # @param [Fixnum] top Vertical offset
    #
    def by(left, top)
      @object.browser.execute_script('window.scrollBy({left: arguments[0], top: arguments[1], behaviour: "smooth"});', Integer(left), Integer(top))
      self
    end

    #
    # Scrolls to specified location.
    # @param [Symbol] param
    #
    def to(param = :top)
      args = @object.is_a?(Watir::Element) ? element_scroll(param) : browser_scroll(param)
      raise ArgumentError, "Don't know how to scroll #{@object} to: #{param}!" if args.nil?

      @object.browser.execute_script(*args)
      self
    end

    private

    def element_scroll(param)
      script = case param
               when :top, :start
                 'arguments[0].scrollIntoView({behavior: "smooth"});'
               when :center
                 <<-JS
                   var bodyRect = document.body.getBoundingClientRect();
                   var elementRect = arguments[0].getBoundingClientRect();
                   var left = (elementRect.left - bodyRect.left) - (window.innerWidth / 2);
                   var top = (elementRect.top - bodyRect.top) - (window.innerHeight / 2);
                   window.scrollTo({left: left, top: top, behaviour: "smooth"});
                 JS
               when :bottom, :end
                 'arguments[0].scrollIntoView({block: "end", inline: "nearest", behavior: "smooth"});'
               else
                 return nil
               end
      [script, @object]
    end

    def browser_scroll(param)
      case param
      when :top, :start
        'window.scrollTo({left: 0, top: 0, behaviour: "smooth"});'
      when :center
        y = '(document.body.scrollHeight - window.innerHeight) / 2 + document.body.getBoundingClientRect().top'
        "window.scrollTo(window.outerWidth / 2, #{y});"
      when :bottom, :end
        'window.scrollTo({left: 0, top: document.body.scrollHeight, behavior: "smooth");'
      when Array
        ['window.scrollTo({left: arguments[0], top: arguments[1], behavior: "smooth");', Integer(param[0]), Integer(param[1])]
      end
    end
  end
end
