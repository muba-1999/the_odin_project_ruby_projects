def merge_sort(array)
	if array.length > 1
		left_half = array[...array.length / 2]
		right_half = array[array.length / 2 ...]

		merge_sort(left_half)
		merge_sort(right_half)
		merge(array, left_half, right_half)
	end
end

def merge(array, left, right)
	#This is the function that merges the array after it has been sorted

	i = 0
	j = 0 
	k = 0

	while i < left.length && j < right.length
		if left[i] < right[j]
			array[k] = left[i]
			i += 1
		else
			array[k] = right[j]
			j += 1
		end 
		k += 1
	end

	while i < left.length
		# this checks if there elements remaining on the left side we transfer them to the merged array
		
		array[k] = left[i]
		i += 1
		k += 1
	end

	while j < right.length
		# this checks if there elements remaining on the left side we transfer them to the merged array

		array[k] = right[j]
		j += 1
		k += 1
	end
	return array
end

p merge_sort([13, 14, 15, 10,9,8,7,11, 12, 5,6,4,3,2,1])