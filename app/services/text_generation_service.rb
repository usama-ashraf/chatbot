require 'openai'
require 'httparty'

class TextGenerationService
  def self.generate_text(prompt)
    api_url = 'https://api.openai.com/v1/engines/davinci/completions'
    api_key = ENV["OPENAI_API_KEY"]

    headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
    }
    text = "You are a helpful and informative bot.\nYou: #{prompt}\nBot:"

    data = {
        prompt: text,
        max_tokens: 50,
        temperature: 0.5
    }
    response = HTTParty.post(api_url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body)
    response_body['choices'][0]['text']
  end
end
