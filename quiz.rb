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
	attr_accessor :counter_hash, :standards_counts, :questions_counts, :question_ids
	attr_reader :num_questions

	def initialize(num_questions, strands)
		@num_questions = num_questions
		@strands = strands
		@standards_counts = {}
		@questions_counts = {}
		@quiz_questions = []
		@question_ids = []
	end

	#creating a method to create a list of strands to cycle through
	def question_ids_list
		self.questions_for_quiz.each do |q|
			@question_ids << q.question_id
		end
		@question_ids[0..(@num_questions-1)]
	end

	def questions_for_quiz
		# until the length of @quiz_questions is >= num_questions
			# in each strand alternately
				# find the standard with the minimum count
					# find the question with the minumum count
						# add that question to the list
		# return the array of question_list of length of num_questions
		self.standards_starting_count
		self.questions_starting_count
		
		# until @quiz_questions.length >= @num_questions

			if @quiz_questions.length.even?
				strand = @strands[0]
			else
				strand = @strands[1]
			end

			strand.standards.each_with_index do |standard, index|
				min_used_standard = @standards_counts.min_by {|k, v| v}
				
				if standard.standard_name == min_used_standard[0]
					standards_counter(min_used_standard[0])
				end
				#returns all that meet min (as array key/value pairs)
				min_used_question = questions_counts.min_by {|k, v| v}
				
				standard.questions.map do |question|
					if question.question_id == min_used_question[0]
						questions_counter(min_used_question[0])
						@quiz_questions << question
					end
				end
				
				
				# if @quiz_questions.length >= @num_questions
				# 	p @standards_counts
				# 	p @questions_counts
				# 	return @quiz_questions
				# end
			end
			@quiz_questions
		# end
				
	end
	#creates hash of all standards with value (num used in quiz) set to 0
	def standards_starting_count
		@strands.each do |strand|
			strand.standards.each do |standard|
				@standards_counts[standard.standard_name] = 0
			end
		end
		@standards_counts
	end

	#Adds to each item in the standard_counts as it is utilized in the quiz
	def standards_counter(category)
		@standards_counts[category] += 1
		@standards_counts
	end

	def questions_starting_count
		@strands.each do |strand|
			strand.standards.each do |standard|
				standard.questions.each do |question|
					@questions_counts[question.question_id] = 0
				end
			end
		end
		@questions_counts
	end

	def questions_counter(category)
		@questions_counts[category] += 1
		@questions_counts
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

puts "How many quiz questions do you want?"
	quantity = gets.chomp.to_i
	# if quantity > 0 && quantity.
quiz = CustomQuiz.new(quantity, parser.strands)
p quiz.questions_for_quiz
p quiz.question_ids_list

	