# URL Shortener

By Wei Hup

This is a URL shortener application built on Ruby on Rails. There is not too much fancy stuff like auth with `devise` as I try to keep it as simple as possible so the Authentication for example is just a basic username and password session based authentication which works very well for this project.

## Ruby version

This project uses Ruby 3.3.0.

## System dependencies

This project uses the following gems and libraries:

- Rails 7.1
- SQLite for the database
- Tailwind CSS for styling
- `bcrypt` for secure password hashing
- `nokogiri` for parsing HTML (used for scraping title tags)
- `geocoder` for getting visitors'\*\*\*\* geolocation

## Configuration

1. Clone the repository:

   ```
   git clone https://github.com/your-username/url-shortener.git
   cd url-shortener
   ```

2. Install dependencies:

   ```
   bundle install
   ```

3. Set up the database:

   - SQLite is already included with Rails, so no additional setup is required.

4. Create and initialize the database:
   ```
   rails db:create
   rails db:migrate
   ```

## Deployment

To start the server, run:

```bash
rails server
```

Visit `http://localhost:3000` in your web browser to access the application.

## Running tests

This project uses the default Rails testing framework. To run the test suite, execute:

```bash
rails test
```

## Features

- User registration and authentication
- Creation of short URLs
- Redirection from short URLs to original URLs
- Analytics for each short URL (clicks, locations)
- User dashboard to manage and view analytics for their short URLs
