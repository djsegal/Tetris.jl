function raise_defeat(cur_player::AbstractPlayer)
  cur_player.is_playing = false

  cur_html = """
    <script class="cs-step-script">
      \$(".cs-step-script").parent().css("padding", 0)
      alert("You lost :(")
    </script>
  """

  display(HTML(cur_html))
end
