class Node
	attr_accessor :value, :next_node

	def initialize(value)
		@value = value
		@next = nil
	end
end

class LinkedList
	attr_accessor :head

	def initialize
		@head = nil
	end

	def append(value)
		if @head.nil?
			@head = Node.new(value)
		else
			current_node = @head
			
			until current_node.next_node.nil?
				current_node = current_node.next_node
			end
			current_node.next_node = Node.new(value)
		end
	end

	def prepend(value)
		if @head.nil?
			@head = Node.new(value)
		else
			prev_node = @head
			@head = Node.new(value)
			@head.next_node = prev_node
		end
	end

	def size
		count = 0
		node = @head

		while !node.nil?
			node = node.next_node
			count += 1
		end 
		return count
	end

	def head
		return if @head.nil?
		return @head.value
	end

	def tail
		node = @head
		return if @head.nil?

		until node.nil?
			if node.next_node.nil?
				return node.value
			end
			node = node.next_node
		end
	end

	def at(index)
		count = 0
		node = @head
		return if @head.nil?

		until node.nil?
			if index == count
				return node.value
			end
			count += 1
			node = node.next_node
		end
	end

	def pop
		return nil if @head.nil?
		if @head.next_node.nil?
			@head = nil
			return nil
		end
		second_last = @head

		while second_last.next_node.next_node
			second_last = second_last.next_node
		end
		second_last.next_node = nil
	end

	def contains?(value)
		node = @head
		return if @head.nil?

		until node.nil?
			return true if node.value == value
			node = node.next_node
		end
		return false
	end

	def find(value)
		count = 0
		node = @head

		return if @head.nil?

		until node.nil?
			return count if node.value == value
			count += 1
			node = node.next_node
		end
	end

	def to_s
		node = @head
		str = ""

		until node.nil?
			str = str + node.value.to_s + " -> " 
			node = node.next_node
		end
		return str + 'nil'
	end
end

l = LinkedList.new

l.append(2)
l.append(3)
l.append(4)
l.append(5)
l.append(6)
l.append(7)
l.append(8)
l.prepend(1)

puts l.to_s
puts
p "size before popping: #{l.size}"
l.pop
p "The value at index 3 is #{l.at(3)}"
p "Head: #{l.head}"
p "size after popping: #{l.size}"
puts
puts l.to_s
puts
p "is 3 in the list #{l.contains?(3)}"
p "7 is at index: #{l.find(7)}"
p "Tail: #{l.tail}"


