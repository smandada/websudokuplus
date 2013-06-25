class Sudoku 
	
	include Math

	@@sub_grid_size = 0

	def valid_sudoku?(sudokuplus_file)

		require 'csv'

		begin
			if sudokuplus_file
				@sudoku_grid = []

				# Read each row and create a grid
				CSV.foreach(sudokuplus_file.path, headers: false) do |row|
					
					#assuming every value is int
					int_row = row.map { |v| v.to_i  }
					@sudoku_grid << int_row
				end

				unless check_if_grid_is_square
					raise 'Row and column count donot match'
				end

				unless check_if_column_size_has_an_integer_squareroot
					raise 'Row/column count is not a square root'
				end

				check_sub_grids
			else
				raise 'Missing file'
			end

			return true
		rescue Exception => e
			puts e
			return false, e
		end
	end

	private

	def check_if_grid_is_square
		@sudoku_grid.size == @sudoku_grid[0].size
	end

	def check_if_column_size_has_an_integer_squareroot
		sub_grid_size = Math.sqrt(@sudoku_grid.size)
		if sub_grid_size.modulo(1) == 0
			@@sub_grid_size = sub_grid_size.to_i
			true
		else
			false
		end
	end

	def check_if_unique_values(values)
		values.uniq.length == values.length
	end

	def check_rows_size_value_limits_and_uniqueness
		same_size_row_check = true
		@sudoku_grid.each do |row| 

			same_size_row_check = same_size_row_check && (row.size == @sudoku_grid.size)

			unless same_size_row_check
				raise 'Rows are not of same size'
			end

			row.each do |value|
				unless value > 0 && value < row.size+1
					raise 'Rows have an out of limits value'
				end
			end

			unless check_if_unique_values(row)
				raise 'Rows do not have unique values'
			end
		end
	end

	def check_each_column_uniqueness
		(0..@sudoku_grid.size-1).each do |column_index|

			column = []
   		(0..@sudoku_grid.size-1).each do |row_index|
   			 column << @sudoku_grid[row_index][column_index]
   		end

   		unless check_if_unique_values(column)
   			raise 'Columns are not unique'
   		end
		end
	end

	def check_sub_grids
		start_row_index = 0
		end_row_index = @@sub_grid_size-1

		while end_row_index < @sudoku_grid.size
			start_column_index = 0
			end_column_index = @@sub_grid_size-1

			while end_column_index < @sudoku_grid.size
				sub_grid = []

				(start_row_index..end_row_index).each do |i|
					(start_column_index..end_column_index).each do |j|
						sub_grid << @sudoku_grid[i][j]
					end
				end
				
				unless check_if_unique_values(sub_grid)
					raise 'Subgrids donot have unique values'
				end

				# Move to next column of grids
				start_column_index = end_column_index+1
				end_column_index = end_column_index + @@sub_grid_size
			end

			# Move to next row of grids
			start_row_index = end_row_index+1
			end_row_index = end_row_index + @@sub_grid_size
		end
	end

end