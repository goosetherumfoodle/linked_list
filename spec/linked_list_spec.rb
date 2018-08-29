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

  describe 'equality' do
    context 'with nodes of equal values' do
      it 'is equal' do
        list_1 = LinkedList::LinkedList.build('a', 'b', 1, 2)
        list_2 = LinkedList::LinkedList.build('a', 'b', 1, 2)

        expect(list_1 == list_2).to be_truthy
      end
    end

    context 'with nodes of unequal values' do
      it 'is not equal' do
        list_1 = LinkedList::LinkedList.build(1, 2, 3, 4)
        list_2 = LinkedList::LinkedList.build(1, 2, 3, 'd')

        expect(list_1 == list_2).to be_falsey
      end
    end

    context 'with different sizes' do
      it 'is not equal' do
        list_1 = LinkedList::LinkedList.build(1, 2, 3, 4)
        list_2 = LinkedList::LinkedList.build(1, 2, 3)

        expect(list_1 == list_2).to be_falsey
        expect(list_2 == list_1).to be_falsey
      end
    end
  end

  describe '#map' do
    it 'creates new list using block' do
      list =    LinkedList::LinkedList.build(1, 2, 3, 4, 5)
      squared = LinkedList::LinkedList.build(1, 4, 9, 16, 25)

      result = list.map { |n| n * n }

      expect(result).to eq(squared)
    end

    it 'does not mutate original list' do
      list = LinkedList::LinkedList.build(1, 2, 3)
      dupe = LinkedList::LinkedList.build(1, 2, 3)

      list.map { |n| n * n }

      expect(list).to eq(dupe)
    end
  end

  describe '#insert_after' do
    context 'in middle of list' do
      it 'inserts after predicate block is truthy' do
        new_node = LinkedList::LinkedList.build(3)
        list = LinkedList::LinkedList.build(1, 2, 4)
        expected = LinkedList::LinkedList.build(1, 2, 3, 4)

        list.insert_after!(new_node) { |n| n.value == 2 }

        expect(list).to eq(expected)
      end
    end

    context 'at end of list' do
      it 'if no node mades predicate block truthy, will insert at end' do
        new_node = LinkedList::LinkedList.build(4)
        list = LinkedList::LinkedList.build(1, 2, 3)
        expected = LinkedList::LinkedList.build(1, 2, 3, 4)

        list.insert_after!(new_node) { |_| false }

        expect(list).to eq(expected)
      end
    end
  end

  describe '#delete_when!' do
    context 'in middle of list' do
      it 'inserts after predicate block is truthy' do
        list = LinkedList::LinkedList.build(1, 2, 3)
        expected = LinkedList::LinkedList.build(1, 3)

        list.delete_when! { |n| n.value == 2 }

        expect(list).to eq(expected)
      end
    end

    context 'predicate always false' do
      it 'doesn\'t modify the list' do
        list = LinkedList::LinkedList.build(1, 2, 3)
        expected = LinkedList::LinkedList.build(1, 2, 3)

        list.delete_when! { |_| false }

        expect(list).to eq(expected)
      end
    end
  end

    describe '#delete_node!' do
    context 'in middle of list' do
      it 'removes node' do
        list = LinkedList::LinkedList.build(1, 2, 3)
        to_delete = list.next_node
        expected = LinkedList::LinkedList.build(1, 3)

        list.delete_node!(to_delete)

        expect(list).to eq(expected)
      end
    end

    context 'when node not present' do
      it 'doesn\'t modify the list' do
        list = LinkedList::LinkedList.build(1, 2, 3)
        to_delete = LinkedList::LinkedList.build('a')
        expected = LinkedList::LinkedList.build(1, 2, 3)

        list.delete_node!(to_delete)

        expect(list).to eq(expected)
      end
    end
  end
end
