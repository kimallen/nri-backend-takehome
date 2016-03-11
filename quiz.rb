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
	attr_accessor :counter_hash
	attr_reader :num_questions
	def initialize(num_questions, strands)
		@num_questions = num_questions
		@strands = strands
		@standards_counts = {}
		@question_counts = {}
		@quiz_questions = []
	end

	#creating a method to create a list of strands to cycle through
	def questions_for_quiz
		# until the length of @quiz_questions is >= num_questions
			# in each strand alternately
				# find the standard with the minimum count
					# find the question with the minumum count
						# add that question to the list
		# return the array of question_list of length of num_questions
		until @quiz_questions.length >= @num_questions
			
			min_key = strands[0].standards.min_by |k, v| {v}.key

			strands[0].standards.each do |standard|
				if standard.standard_name == min_key
					standards_counter(min_key)
				end
				
				min_key = standard.questions.min_by |k, v|{v}.key
				standard.questions.each do |question|
					if question.question_id == min_key
						@quiz_questions << question
					end
				end
			end
		end
		# @strands[1].standards[0].questions[0]
	end
	#creates hash of all standards with value (num used in quiz) set to 0
	def standards_starting_count
		@strands.each do |strand|
			strand.standards.each do |standard|
			@standards_counts[standard.standard_name] = 0
		end
		@standards_counts
	end
	#Adds to each item in the standard_counts as it is utilized in the quiz
	def standards_counter(category)
		@standards_counts[category] += 1
	end

	def questions_starting_count
			@standards.each do |standard|
			standard.questions.each do |question|
			@questions_counts[question.question_id] = 0
		end
		@standards_counts
	end

	def standards_counter(category)
		@questions_counts[category] += 1
	end

end

class Parser

	attr_reader :standards, :strands

	def initialize(file)
		@file = file
		@standards = []
		@strands = []
	end

	# returns an object of strands (@strands) that have standards that have questions
	def parse_file

		CSV.foreach(@file, :headers => true) do |row|

		  question = Question.new(question_id: row["question_id"], difficulty: row["difficulty"])
		  
		  #Creates association "standard has many questions"
		  standard = nil
		  @standards.each do |single_standard|
		  	if single_standard.standard_id == row["standard_id"]
			  	standard = single_standard
				end
			end
		  
		  if standard == nil	
		  	standard = Standard.new(standard_id: row["standard_id"], standard_name: row["standard_name"])
			  @standards << standard
		  end

		  standard.questions << question
		 	  
		 	#Creates association of "strand has many standards"
		 	 strand = nil
		  @strands.each do |single_strand|
		  	if single_strand.strand_id == row["strand_id"]
			  	strand = single_strand
				end
			end
		  
		  if strand == nil	
		  	strand = Strand.new(strand_id: row["strand_id"], strand_name: row["strand_name"])
			  @strands << strand
		  end

		  strand.standards << standard
		 	
		end
		@strands
	end

end

parser = Parser.new("questions.csv")
strands = parser.parse_file
strands[0].standards[0].questions[0]
quiz = CustomQuiz.new(5, parser.strands)
p quiz.questions_for_quiz
	