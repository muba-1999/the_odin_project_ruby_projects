class Node
	attr_accessor :data, :left, :right

	def initialize(data)
		@data = data
		@left = nil
		@right = nil
	end
end

class Tree
	attr_accessor :root, :array

	def initialize(array)
		@array = array.sort.uniq
		@root = build_tree(@array) 
	end

	def build_tree(array, start = 0, end_point = array.length - 1)
		return nil if start > end_point

		mid = (start + end_point) / 2
		root_node = Node.new(array[mid])

		root_node.left = build_tree(array, start, mid - 1)
		root_node.right = build_tree(array, mid + 1, end_point)

		return root_node
	end

	def insert(value, root = @root)
		if root.nil?
			root = Node.new(value)
		end

		if root.data > value
			if root.left.nil?
				root.left = Node.new(value)
				return
			end
			insert(value, root.left)
		end
		if root.data < value
			if root.right.nil?
				root.right = Node.new(value)
				return
			end
			insert(value, root.right)
		end
	end

	def delete(value, root = @root)
		if root.nil?
			return nil
		elsif value < root.data
			root.left = delete(value, root.left)
		elsif value > root.data
			root.right = delete(value, root.right)
		else
			if (root.left.nil? && root.right.nil?)
				root = nil
			elsif root.left.nil?
				node = root
				root = root.right
				node = nil
			elsif root.right.nil?
				node = root
				root = root.left
				node = nil
			else
				node = find_min(root.right)
				root.data = node.data
				root.right = delete(root.right, node.data)
			end
		end
		return root
	end

	def find_min(root)
		while root.left
			root = root.left
		end
		return root
	end

	def find(value)
		queue = [@root]

		return nil if @root.nil?
		if @root.data == value
			return self
		else
			while queue.length > 0
				node = queue.shift
				if node.data == value
					return node
				else
					queue << node.left unless node.left.nil?
					queue << node.right unless node.right.nil?
				end
			end
		end
		return nil
	end

	def level_order
		queue = [@root]

		return queue unless block_given?

		while queue.length > 0
			node = queue.shift
			yield node.data

			queue << node.left unless node.left.nil?
			queue << node.right unless node.right.nil?
		end
	end

	def inorder
		current_node = @root
		stack = []

		return nil if @root.nil?

		while !stack.empty? || !current_node.nil?
			unless current_node.nil?
				stack << current_node
				current_node = current_node.left
			else
				current_node = stack.pop
				yield current_node.data
				current_node = current_node.right
			end
		end
	end

	def preorder
		stack = [@root]

		return nil if @root.nil?

		while stack.length > 0
			node = stack.pop
			yield node.data

			stack << node.right unless node.right.nil?
			stack << node.left unless node.left.nil?
		end
	end
end




