const max_level = 42

const score_array = [
  100,
  300,
  500,
  800
]

const allowed_labels = [
  "clear",
  "combo",
  "soft",
  "hard",
  "glue",
  "hold"
]

const color_list = [
  "blue",
  "cyan",
  "green",
  "orange",
  "purple",
  "red",
  "yellow"
]

const crayon_dict = Dict()

crayon_dict["invisible"] = Crayon()

for cur_color in color_list
  tmp_color = cur_color

  ( tmp_color == "blue" ) &&
    ( tmp_color = "royalblue")

  cur_piece_color = "$(tmp_color)3"
  cur_shadow_color = "$(tmp_color)1"

  if tmp_color == "yellow"
    cur_piece_color = "yellow2"
  end

  crayon_dict[cur_color] = Crayon(
    background = Colors.color_names[cur_piece_color]
  )

  crayon_dict["$(cur_color)_shadow"] = Crayon(
    background = Colors.color_names[cur_shadow_color]
  )
end

crayon_dict["grey"] = Crayon(
  foreground = Colors.color_names["darkgrey"]
)

const odd_offsets = Dict(
  [ 0 , 1 ] => (
    ( -1 , +0 ),
    ( -1 , +1 ),
    ( +0 , -2 ),
    ( -1 , -2 )
  ),
  [ 1 , 2 ] => (
    ( +1 , +0 ),
    ( +1 , -1 ),
    ( +0 , +2 ),
    ( +1 , +2 )
  ),
  [ 2 , 3 ] => (
    ( +1 , +0 ),
    ( +1 , +1 ),
    ( +0 , -2 ),
    ( +1 , -2 )
  ),
  [ 0 , 3 ] => (
    ( -1 , +0 ),
    ( -1 , -1 ),
    ( +0 , +2 ),
    ( -1 , +2 )
  )
)

const even_offsets = Dict(
  [ 0 , 1 ] => (
    ( -2 , +0 ),
    ( +1 , +0 ),
    ( -2 , -1 ),
    ( +1 , +2 )
  ),
  [ 1 , 2 ] => (
    ( -1 , +0 ),
    ( +2 , +0 ),
    ( -1 , +2 ),
    ( +2 , -1 )
  ),
  [ 2 , 3 ] => (
    ( +2 , +0 ),
    ( -1 , +0 ),
    ( +2 , +1 ),
    ( -1 , -2 )
  ),
  [ 0 , 3 ] => (
    ( +1 , +0 ),
    ( -2 , +0 ),
    ( +1 , -2 ),
    ( -2 , +1 )
  )
)
