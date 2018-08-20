require "linked_list/version"

module LinkedList
  class LinkedList
    include Enumerable

    attr_accessor :value, :next_node

    def initialize(value, next_node=nil)
      @value = value
      @next_node = next_node
    end

    def self.build(first_value, *rest)
      first_node = new(first_value)

      rest.reduce(first_node) do |node, value|
        node.next_node = self.new(value)
      end

      first_node
    end

    def reverse
      return self if !next_node

      next_node.reduce(self.class.new(value)) do |rev_list, node|
        rev_list.push(node.value)
      end
    end

    def reverse!(new_next_node = nil)
      old_next_node = next_node
      self.next_node = new_next_node
      reverse_next_node(old_next_node)
    end

    def push(new_value)
      self.class.new(new_value, self)
    end

    def each(&block)
      yield self
      next_node.each(&block) if next_node
    end

    def map(&block)
      new_value = yield value
      new_next_node = next_node.map(&block) if next_node
      self.class.new(new_value, new_next_node)
    end

    def print_values
      each(&:print_value)
    end

    def print_value
      if next_node
        print "#{value} ----> "
      else
        puts "#{value}"
      end
    end

    def ==(list)
      eq_value(list) && eq_tail(list)
    end

    def end_of_list?
      !next_node
    end

    private

    def reverse_next_node(node)
      node&.reverse!(self) || self
    end

    def both_end_of_list?(node)
      end_of_list? && node.end_of_list?
    end

    def eq_value(node)
      value == node&.value
    end

    def eq_tail(node)
      both_end_of_list?(node) || next_node == node.next_node
    end
  end
end
