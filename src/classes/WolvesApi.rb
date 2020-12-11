class WolvesApi
  attr_accessor :status

  def initialize(username)
    response = HTTParty.get("https://api.github.com/users/#{username}")
    @status = response.code
    @parser = JSON.parse response.to_s
  end
end

class WolvesInfos < WolvesApi
  def getResume
    if(@status == 200)
      pars = ["name", "bio", "followers", "following"]
      results = []

      pars.each { |cont| results.push(@parser[cont]) }

      return """#{results[0].to_s.rjust(8," ")} ~ #{results[1]}
      #   #{results[2].to_s.rjust(8," ")}  Followers
      #   #{results[3].to_s.rjust(8," ")}  Following"""
    else
      return @status
    end
  end
end