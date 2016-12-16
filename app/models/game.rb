class Game < ActiveRecord::Base
  belongs_to :phone
  has_many :rounds

  # retrieve API info
  def get_api_response(endpoint)
    uri = URI.parse(URI.encode(endpoint))
    api_response = Net::HTTP.get(uri)
    JSON.parse(api_response)
  end

  # select one question's data
  def play
    data = self.get_api_response("https://opentdb.com/api.php?amount=3&category=11")["results"][0]
    return data
  end

  # format possible answers w/ (A) xxxx (B) xxx format
  def set_poss(data)
    poss_answers = []
    poss_answers.push("(A)" + " " + data["correct_answer"])
    wrong_answers = data["incorrect_answers"]
    alphabet = ('A'..'Z').to_a
    wrong_answers.each_with_index do |ans, i|
      poss_answers.push("(" + alphabet[i+1] + ")" + " " + ans)
    end
    return poss_answers
  end

end
