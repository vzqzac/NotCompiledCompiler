class Compiler < ActiveRecord::Base
  RESERVE = 'reserve'
  OPERAND = 'operand'
  SYMBOL = 'symbol'
  OTHER = 'other'
  VARIABLE = 'variable'
  RESERVE_WORDS = %w[main #include return define]
  METHODS = %w[if else for do while]
  VARIABLE_TYPES = %w[int float double char string]
  OPERANDS = %w[+ - = * /]
  SYMBOLS = %w[< > ( ) { } ;]


  def validate_words(words)

    words_types = []
    words.split(/[ ,;\r\n(><)]+/).each do |word|
      if RESERVE_WORDS.include? word
        words_types << [word,RESERVE]
      elsif  OPERANDS.include? word
        words_types << [word, OPERAND]
      elsif SYMBOLS.include? word
        words_types << [word, SYMBOL]
      elsif VARIABLE_TYPES.include? word
        words_types << [word,VARIABLE]
      else
        words_types << [word,OTHER]
      end
    end
    words_types
  end

  def lexical_part
    words_types = validate_words(source_code)
    # puts words_types

  end

  def validate_line(lines,index)
    return if lines[index].empty?
    words = validate_words lines[index].gsub( "\n" , "")
    if words[0][1] == VARIABLE
      variable_allocation
    end

  end

  def syntactic_part
    lines = source_code.split(/\n?\r/)
    lines.each_with_index  do |line,index|
      validate_line lines,index
    end
    lines
  end



  def variable_allocation
    puts 'pedo'
  end
end
