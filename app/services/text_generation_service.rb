require 'openai'
require 'httparty'

class TextGenerationService
  def self.generate_text(prompt)
    api_url = 'https://api.openai.com/v1/engines/text-davinci-003/completions'
    api_key = ENV["OPENAI_API_KEY"]

    headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
    }

    data = {
      prompt: text_prompt(prompt),
      temperature: 1,
      max_tokens: 100,
      top_p: 0.5,
      frequency_penalty: 0.7,
      presence_penalty: 1,
      best_of: 1
    }
    response = HTTParty.post(api_url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body)

    # Check if the response has any content for the bot's reply
    if response_body['choices'].empty?
      # If no content, indicate that the model didn't understand the prompt
      return "I'm sorry, I don't understand the question. Please rephrase it."
    else
      # Extract the bot's reply from the response
      bot_reply = response_body['choices'][0]['text']
      # Remove any text before the bot's response (i.e., "You:")
      bot_reply = bot_reply.split("Bot: ")&.last&.strip

      return bot_reply
    end
  end

  def self.text_prompt(user_message) # Make text_prompt a class method
    <<~PROMPT
    You: #{user_message}
    Bot: Sure! I'm here to help. How can I assist you today?
    PROMPT
  end
end
