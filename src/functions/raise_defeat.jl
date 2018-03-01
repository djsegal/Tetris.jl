function raise_defeat(cur_player::AbstractPlayer)
  cur_player.state.is_playing = false
  cur_player.state.has_lost = true

  cur_html = """
    <script class="cs-step-script">
      \$(".cs-step-script").parent().css("padding", 0)
      alert("You lost :(")
    </script>
  """

  display(HTML(cur_html))
end
