class SudokusController < ApplicationController
  
  def index

  end 

  def check
    if params[:file]
      sudoku_checker = Sudoku.new
      result, error_messages  = sudoku_checker.valid_sudoku?(params[:file])  
    else
      error_messages = "Missing file"
      result = false
    end

    if result
      result_message = "Valid SudokuPlus"
    else
      result_message = "Invalid SudokuPlus"

      error_messages = error_messages.to_s

      if error_messages.size > 0 
        result_message = result_message + " Error: " + error_messages
      end
    end
    # puts '*'*40
    # puts result_message
    # puts '*'*40
    redirect_to root_url, notice: result_message
  end 
end
