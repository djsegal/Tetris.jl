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

    .cs-how-to {
      position: absolute;
      bottom: 0;
      right: 0;
      margin-bottom: 1.08em;
      margin-right: 1.08em;
      text-align: center;
      font-weight: bold;
      font-family: monospace;
      opacity: 0.8;;
    }

    .js-shadow-piece:not(.js-active-piece) {
      opacity: 0.3;
      border: solid 1px #F1F1F1 !important;
    }

    .js-shadow-piece:not(.js-active-piece).cs-no-top-border {
      border-top: none !important;
    }

    .js-shadow-piece:not(.js-active-piece).cs-no-bottom-border {
      border-bottom: none !important;
    }

    .js-shadow-piece:not(.js-active-piece).cs-no-left-border {
      border-left: none !important;
    }

    .js-shadow-piece:not(.js-active-piece).cs-no-right-border {
      border-right: none !important;
    }

  </style>
"""
