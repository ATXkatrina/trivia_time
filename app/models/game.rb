class Game < ActiveRecord::Base
  belongs_to :phone
  has_many :rounds

  def get_api_response(endpoint)
    uri = URI.parse(URI.encode(endpoint))
    api_response = Net::HTTP.get(uri)
    JSON.parse(api_response)
  end

  def play
    data = self.get_api_response("https://opentdb.com/api.php?amount=3&category=11")["results"][0]
    question_set = []
    question_set.push(data["question"])
    question_set.push(data["correct_answer"])
    return question_set
  end

end
