module CsvParser

  class Parser
    RETURN_CODE = "\n"
    attr_accessor :blank_letter, :skip_empty_row, :min_column_count
    attr_reader :skip_keywords

    def initialize
      @skip_keywords = []
    end

    def parse(csv)
      @csv = csv.gsub("\r\n", "\n").gsub("\r", "\n")
      @result = []
      @row = []
      @buffer = ''
      @enclosing_flag = false
      @current_position = 0
      @current_letter = ''

      while @current_position < @csv.length do
        @current_letter = @csv[@current_position]
        case @current_letter
          when ','
            if @enclosing_flag
              @buffer << @current_letter
            else
              end_value
            end
          when '"'
            if @enclosing_flag
              if get_next_letter == '"'
                @buffer << '"'
                @current_position += 1
              else
                end_value
                if get_next_letter == ','
                  @current_position += 1
                elsif is_next_char_return_code
                  @current_position += 1
                  end_row
                end
              end
            else
              @enclosing_flag = true
            end
          else
            if is_return_code
              if @enclosing_flag
                @buffer << RETURN_CODE
              else
                end_value
                end_row
              end
            else
              @buffer << @current_letter
            end
        end
        @current_position += 1
      end

      end_value
      end_row

      last_row = @result[@result.length - 1]
      if !last_row or check_all_null(last_row)
        @result.delete_at(-1)
      end

      @csv = nil
      @result
    end

    private

    def end_value
      value = @buffer.length == 0 ? blank_letter : @buffer
      @row.push(value)
      @enclosing_flag = false
      @buffer = ''
    end

    def end_row
      is_empty = check_all_null(@row)
      if skip_empty_row and is_empty
        @row = []
      elsif !skip_keywords and @row.length > 0 and skip_keywords.include!(@row[0])
      else
        while min_column_count and @row.length < min_column_count
          @row.push(blank_letter)
        end
        @result.push(@row)
      end
      @row = []
    end

    def check_all_null(list)
      flag = true
      list.each { |word|
        if !word.nil? and !word.empty?
          flag = false
          break
        end
      }
      flag
    end

    def is_return_code
      RETURN_CODE == @current_letter
    end

    def is_next_char_return_code
      RETURN_CODE == get_next_letter
    end

    def get_next_letter
      @csv[@current_position + 1]
    end
  end
end