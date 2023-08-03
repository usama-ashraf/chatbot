require 'openai'
require 'httparty'

class TextGenerationService
  def self.generate_text(prompt)
    api_url = 'https://api.openai.com/v1/engines/davinci/completions'
    api_key = "YOUR_API_KEY"

    headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
    }

    data = {
        prompt: prompt,
        max_tokens: 100,
        temperature: 0.7
    }
    response = HTTParty.post(api_url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body)
    response_body['choices'][0]['text']
  end
end
