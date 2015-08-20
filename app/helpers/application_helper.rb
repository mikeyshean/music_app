module ApplicationHelper

  def authenticity_token
    <<-HTML.html_safe
      <input
        type="hidden"
        name="authenticity_token"
        value=#{form_authenticity_token}>
    HTML
  end

  def ugly_lyrics(lyrics)
    formatted_lyrics = lyrics
      .split("\n")
      .map { |line| "<pre>&#9835; #{line}</pre><br>"}
      .join("")
      
    formatted_lyrics.html_safe
  end
end
