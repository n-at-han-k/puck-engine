# frozen_string_literal: true

# Pin Stimulus controllers
pin_all_from PuckEngine::Engine.root.join("app/javascript/puck_engine/controllers"),
  under: "controllers/puck_engine", to: "puck_engine/controllers"

# Pin Puck packages from CDN
pin "@puckeditor/core", to: "https://unpkg.com/@puckeditor/core@0.21.1/dist/index.mjs"
pin "react", to: "https://unpkg.com/react@18.3.1/umd/react.production.min.js"
pin "react-dom", to: "https://unpkg.com/react-dom@18.3.1/umd/react-dom.production.min.js"

# Pin Puck engine JavaScript
pin "puck_engine/puck_editor", to: "puck_engine/puck_editor.js"
pin "puck_engine/puck_render", to: "puck_engine/puck_render.js"
pin_all_from PuckEngine::Engine.root.join("app/javascript/puck_engine"), under: "puck_engine"
