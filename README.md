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
- `geocoder` for getting visitors' geolocation

## Configuration

1. Clone the repository:

   ```
   git clone https://github.com/AaronTan11/url-shortener.git
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

# Deployed Application

To view the deployed app please click this link:
https://rails.tanweihup.dev/

## Short URL Path Solution

The short URL path solution generates alphanumeric strings between 6 and 10 characters long.

### Implementation

- `SecureRandom.alphanumeric(rand(6..10))` is used to generate random strings.
- The length is randomly chosen between 6 and 10 characters for each URL.
- To ensure uniqueness, I did checking against existing paths in the database.

### Limitations

1. Collision probability increases as more URLs are generated.
2. The random length might not be optimal for all use cases.

### Workarounds

1. If collisions become frequent, we could implement a retry mechanism with an increasing length.
2. For high-volume systems, we could consider using a deterministic algorithm or a distributed ID generator.

### Future Improvements

- Implement custom path creation for premium users.
- Add support for real-time analytics updates (currently removed due to causing deployment errors)

> [!NOTE]
> The url shortening process might take some time, if clicking once does not work, try clicking multiple times.
> There is no error to this as it saves to SQLITE db just fine.
