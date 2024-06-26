# Todo List Web Application

## Introduction
Instinct API is the API for a music streaming/downloading platform, Instinct. 

## Prerequisites/Dependencies
Before you start, ensure you have met the following requirements:
- **Ruby 3.3.1**: Install guide: [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- **Ruby on Rails 7.1.3**: Install guide: [Rails](https://guides.rubyonrails.org/getting_started.html)
- **PostgreSQL 14**: Install guide: [PostgreSQL](https://www.postgresql.org/download/).

## Setup
Before starting the setup, ensure you have the required prerequisites/dependencies

### Clone The Repository
Download the project files or clone the project repository to your local machine

### Install Ruby Dependencies
Install bundler by using `gem install bundler`

Inside the projects main directory (where 'Gemfile' is) run: `bundle install`

### Run postgresql server if not already
To set postgresql start on boot: `sudo systemctl enable postgresql`

populate database after initial postgres install if not done already: `sudo postgresql-setup --initdb --unit postgresql`

To start postgresql server manually: `sudo systemctl start postgresql`

### Database Setup/Creation/Initialization
Setup Database credentials by creating a .env file at the root of the project. Insert these ENV variables: 
```
PG_USERNAME=postgres
PG_PASSWORD=postgres
PG_HOST=localhost
PG_PORT=5432
```
Replace these credentials with your information unless you are using the default postgres user (you may need to set the password for user postgres, see troubleshooting)

Create Database: `rails db:create`

Initialize Database: `rails db:migrate`


### Setup credentials
Generate your credential files: `rails credentials:edit` and save the generated file


### Running/Testing
Start the rails server using: `rails server`


## Troubleshooting

**Error**: `An error occurred while installing pg (1.5.6), and Bundler cannot continue.` 

**Fix**: Try installing PostgreSQL client development libraries:

Debian:
`sudo apt install libpq-dev`

Fedora:
`sudo dnf install postgresql-devel`

__

**Error**: authentication failed for user "postgres" when running rails db:create (for default postgres user)

**Fix**: set the password: `sudo -i -u postgres` then `psql` then `ALTER USER postgres WITH PASSWORD 'yourpassword';`