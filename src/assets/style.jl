style_asset() = """
  <style>
    div.output_area  div.cs-tetris-container:focus {
      outline: none;
    }

    div.output_area  div.cs-tetris-container {
      position: relative;
    }

    div.output_area table.cs-tetris-table {
      margin: 2.5vmin auto;
    }

    .cs-tetris-table *:hover {
      background: initial;
    }

    .cs-tetris-table tr {
      background-color: red;
    }

    .cs-tetris-table td {
      width: 3vmin;
      height: 3vmin;
    }

    .cs-splash-screen {
      position: absolute;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;

      pointer-events: none;
      opacity: 0.84;
      transition: opacity .25s ease-in-out;
      -moz-transition: opacity .25s ease-in-out;
      -webkit-transition: opacity .25s ease-in-out;
    }

    .cs-splash-screen {
      position: absolute;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;

      pointer-events: none;
      opacity: 0.84;
      transition: opacity .25s ease-in-out;
      -moz-transition: opacity .25s ease-in-out;
      -webkit-transition: opacity .25s ease-in-out;
    }

    .cs-splash-screen.cs-disappear {
      opacity: 0;
    }

    .cs-splash-text {
      position: absolute;
      top: 0;
      right: 0;
      margin-right: 1.08em;
    }

  </style>
"""
