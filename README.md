# PuckEngine

A Rails engine that integrates [Puck](https://github.com/puckeditor/puck) - the open-source visual editor for React - to enable building sites with a drag-and-drop page builder.

## What is Puck?

Puck is a modular, open-source visual editor for React.js that enables custom drag-and-drop experiences. This engine wraps Puck's functionality into a mountable Rails engine, allowing you to:

- Create and edit pages visually
- Build sites with custom React components
- Manage page data through Rails models
- Render pages stored in your database

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'puck_engine'
```

And then execute:

```bash
bundle install
```

Mount the engine in your routes:

```ruby
# config/routes.rb
mount PuckEngine::Engine => "/puck"
```

Run the installation generator:

```bash
rails g puck_engine:install
rails db:migrate
```

## Usage

### Accessing the Editor

Navigate to `/puck/editor` to access the visual page builder.

### Creating Pages

Pages are stored as JSON data and can be rendered dynamically. Use the editor to:

1. Add components to your page
2. Configure component properties
3. Save the page data
4. View the rendered page

### Rendering Pages

Pages can be rendered using the built-in render helper:

```erb
<%= puck_render_page(@page) %>
```

Or access pages directly at `/puck/pages/:id`.

## Example App

```bash
cd example
bundle install
bin/dev
```

## License

MIT License - see LICENSE file
