# 🌌 Picmate
![Rocket](https://i.imgur.com/iTQizev.gif)

Have you ever been conflicted about which picture to use for your socials? Worry no more! Picmate is a platform that lets its users connect and share their favorite pictures with their friends. 

## 💡 Features
- Users can sign up and login with a username and password of their choice
- Users can connect with other users through the friend system
- Users can block other users they do not wish to interact with
- Users are able to upload images and provide a name and description
- Users are able to view the images of other users on their friendslist
- Users can search within their own images
- Users can search within their friends' images
- Users can delete unwanted images

## 🛠 Setup
To set up Picmate, either install its dependencies or use the provided `Dockerfile` and `docker-compose.yml`. If you are planning to use Docker, skip to [Docker Setup](#-docker-setup). 

To install the dependencies, clone the repository and make sure you have `ruby 2.6.3` and `postgresql` installed. 

Then configure the database by modifying the `config/database.yml` to match your PostgreSQL credentials. 
```yml
...

development:
  <<: *default
  database: picmate_api_development
  username: YOUR_USERNAME
  password: YOUR_PASSWORD

test:
  <<: *default
  database: picmate_api_test
  username: YOUR_USERNAME
  password: YOUR_PASSWORD

...
```

Lastly, run the following commands to migrate the database and start the server: 
1. `rails db:create`
2. `rails db:migrate`
3. `rails s`

## 🐳 Docker Setup
To run Picmate using Docker, make sure that the host, username, and password in `config/database.yml` match the ones found in the `db` container in `docker-compose.yml`. Additionally, make sure that the line defining the host in `config/database.yml` is uncommented.

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  # host: db # uncomment if using docker

...
```

Once you have verified that these files are properly configured, run: 

```
docker-compose up
```

## 📋 Schema
![Schema](https://i.imgur.com/zHC0eI8.png)

**Note:** The dotted lines represent the polymorphic associations used by Rails Active Storage. 

## 🗂 API
The following functionalities are provided through the RESTful API. 
- **POST** `/sign_up`
  - Creates an account with the provided `username` and `password`
- **POST** `/login`
  - Verifies `username` and `password` to login
- **POST** `/images`
  - Posts an image to the given `owner_id` with a `name` and optional `description`
- **GET** `/images/:id`
  - Returns the URL for the hosted image
- **GET** `/user/:owner_id/images`
  - Returns the URL for all hosted images from `owner_id`
- **GET** `/user/:owner_id/friends/images`
  - Returns the URL for all hosted images from friends of `owner_id`
- **POST** `/relationship/create`
  - Creates a `relationship_type` relationship (either `friend` or `block`) between `relating_user_id` with `related_user_id`
- **DELETE** `/relationship/delete`
  - Deletes the relationship between `relating_user_id` and `related_user_id`
- **POST** `user/images/search`
  - Searches image of the user with id `owner_id` names containing `search_term`
- **POST** `/user/friends/images/search`
  - Searches image of the friends of the user with id `owner_id` names containing `search_term`

## 🧪 Testing
I have written several unit tests using MiniTest to validate the state of my models. Run

```
rails test
```

to run all provided tests.

## 💾 Continuous Integration
GitHub Actions is configured to run the MiniTest tests and verify linting with Rubocop. 