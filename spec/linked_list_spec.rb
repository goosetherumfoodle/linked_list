RSpec.describe LinkedList do
  it "has a version number" do
    expect(LinkedList::VERSION).not_to be nil
  end

  describe '::build' do
    it 'constructs a linked list from multiple values' do
      list = LinkedList::LinkedList.build(1, 2, 3)

      value_1 = list.value
      value_2 = list.next_node.value
      value_3 = list.next_node.next_node.value

      expect(value_1).to eq(1)
      expect(value_2).to eq(2)
      expect(value_3).to eq(3)
    end
  end

  describe '#push' do
    it 'prepends a new value on the the list' do
      list = LinkedList::LinkedList.build(1, 2)

      pushed = list.push('new')

      expect(pushed.value).to match('new')
      expect(pushed.next_node.value).to equal(1)
      expect(pushed.next_node.next_node.value).to equal(2)
    end
  end

  describe '#reverse' do
    it 'creates a list with reversed values' do
      list = LinkedList::LinkedList.build(1, 2, 3)

      reversed = list.reverse
      value_1 = reversed.value
      value_2 = reversed.next_node.value
      value_3 = reversed.next_node.next_node.value

      expect(value_1).to eq(3)
      expect(value_2).to eq(2)
      expect(value_3).to eq(1)
    end

    it 'does not mutate the original list' do
      list = LinkedList::LinkedList.build(1, 2, 3)

      list.reverse
      value_1 = list.value
      value_2 = list.next_node.value
      value_3 = list.next_node.next_node.value

      expect(value_1).to eq(1)
      expect(value_2).to eq(2)
      expect(value_3).to eq(3)
    end
  end

  describe '#reverse!' do
    it 'reverses the values in the list' do
      list = LinkedList::LinkedList.build(1, 2, 3)

      reversed = list.reverse!
      value_1 = reversed.value
      value_2 = reversed.next_node.value
      value_3 = reversed.next_node.next_node.value

      expect(value_1).to eq(3)
      expect(value_2).to eq(2)
      expect(value_3).to eq(1)
    end

    it 'preserves the nodes' do
      list = LinkedList::LinkedList.build(1, 2, 3)

      node_1 = list
      node_2 = list.next_node
      node_3 = list.next_node.next_node

      reversed = list.reverse!

      rev_node_1 = reversed
      rev_node_2 = reversed.next_node
      rev_node_3 = reversed.next_node.next_node

      expect(node_1).to eq(rev_node_3)
      expect(node_2).to eq(rev_node_2)
      expect(node_3).to eq(rev_node_1)
    end
  end
end
