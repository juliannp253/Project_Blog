# BlogApp

Social blogging platform built with Rails 8. Create posts with images, comment on content, and connect with other users through friend requests and a simple profile system.

## Features

- Email/password authentication with secure sessions
- Password reset via token email (Letter Opener in development)
- Posts: create, edit, delete; attach multiple images (Active Storage)
- Comments: add, edit, delete by author
- Friends: search by email, send/accept/decline requests, list/remove friends
- Profile: username, bio, edit profile UI
- Responsive UI using Bootstrap 5 and Font Awesome
- Turbo/Stimulus with Importmap; no Node-based JS bundler required

## Tech Stack

- Ruby `3.3.2`
- Rails `8.x`
- Hotwire (`turbo-rails`, `stimulus-rails`)
- Importmap for JS, `cssbundling-rails` for SCSS/Sass
- Active Storage (Disk) for image uploads
- SQLite (development/test), PostgreSQL ready for production
- RSpec and Cucumber for testing

## Getting Started

### Prerequisites

- Ruby `3.3.2` and Bundler
- SQLite (for local dev) or Postgres (for production)
- Node.js and Yarn (for CSS building via Sass)

### Setup

```bash
bundle install
yarn install
bin/rails db:setup    # or: bin/rails db:create db:migrate
```

### Run (development)

```bash
bin/dev              # Rails server + CSS watcher
# or
bin/rails server     # then in another shell: yarn watch:css
```

Visit `http://localhost:3000`.

### Auth & Navigation

- Sign up: `GET /signup`
- Sign in: `GET /login`
- Password reset: `GET /passwords/new`
- Posts: `GET /`, `GET /posts`, `GET /my_posts`
- Friends: `GET /friends`, friend requests: `GET /friend_requests`

## Configuration

- Active Storage: uses local Disk in development/test (`config/storage.yml`).
- Development mailer: Letter Opener opens emails in the browser (`config/environments/development.rb`).
- Production DB: set `DATABASE_URL` and `DATABASE_PASSWORD` if using Postgres (see `config/database.yml`).
- SMTP (production): configure credentials via `rails credentials:edit` if sending real emails.

## Testing

```bash
bundle exec rspec      # unit/request/mailers
bundle exec cucumber   # BDD feature tests
```

## API

Basic JSON endpoints available via Jbuilder:

- `GET /posts.json`
- `GET /posts/:id.json`

## Deployment

- Container-friendly and compatible with platforms like Render/Fly.io.
- Ensure env vars (e.g., `RAILS_ENV`, `DATABASE_URL`, `RAILS_MASTER_KEY`) are set.
- Configure mail delivery for password resets in production.

## Contributing

Pull requests welcome. For major changes, please open an issue first to discuss what you’d like to change.

## License

This project is intended for educational and portfolio purposes. If you need a specific license attached, open an issue or add a `LICENSE` file.
