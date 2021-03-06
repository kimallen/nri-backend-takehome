# PSEUDOCODE
# Input: number of questions to put in quiz (> 0)
# Output: list of question_ids

# Prompt the user for the number of questions (num_questions)
# parse CSV files
# Create classes for each of the 
	#Strand

	#Standard

	#Question

	#Custom quiz

# Create associations between the classes by creating arrays of Standards and Strands

# create a method to assign strands to each of the custom quiz questions
# for each custom quiz question, cycle through the strands' options of standards of questions.

#return the question_id of each of the chosen questions

require "csv"


class Strand
	attr_accessor :strand_id, :strand_name
	attr_reader :standards
	def initialize(args = {})
		@strand_id = args[:strand_id]
		@strand_name = args[:strand_name]
		@standards = []
	end
#creating a method to create a list of strands to cycle through
	# def strands_for_quiz(num_questions, num_strands)
	# 	strand_list = []
	# 	strands = [1..num_strands]
	# 	strands.shuffle!
	# 	i = 0
	# 	until strand_list.length == num_questions
	# 		strand_list << strands[i]
	# 		i += 1
	# 	end	
	# 	return strand_list
	# end
end

class Standard
	attr_accessor :standard_id, :standard_name
	attr_reader :questions
	def initialize(args = {})
	@standard_id = args[:standard_id]
	@standard_name = args[:standard_name]
	@questions = []
	end
end

class Question
	attr_accessor :question_id, :difficulty
	def initialize(args = {})		
		@question_id = args[:question_id]
		@difficulty = args[:difficulty]
	end
end

class CustomQuiz
	def initialize

	end
	
	def generate_quiz(num_questions)
	end
end

class Parser
questions_array = []

	def initialize(file)
		@file = file
		@strands_array = []
		@standards_array = []
	end

	def parse_file

		CSV.foreach(@file, :headers => true) do |row|
		 
		  strand = Strand.new(strand_id: row["strand_id"], strand_name: row["strand_name"])
		  question = Question.new(question_id: row["question_id"], difficulty: row["difficulty"])
		  standard = Standard.new(standard_id: row["standard_id"], standard_name: row["standard_name"])
		  @standards_array << question
		  # loop through standards_array, check if the standard exists.  If not, push the object into the array
		  if @strands_array.include? standard == false
		  	@strands_array << standard
		  end
		end

	end

end


	