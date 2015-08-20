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

  def delete_button(action)
    <<-HTML.html_safe
      <form action="#{action} %>" method="post">
      #{authenticity_token}
        <input type="hidden" name="_method" value="delete">
        <button>Delete</album>
      </form>
    HTML
  end

  def flash_notice
    notices = ["<ul>"]
    return unless flash[:notice]

    flash[:notice].each { |notice| notices << "<li>#{notice}</li>" }

    notices.push("</ul>").join("").html_safe
  end

end
