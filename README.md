
# Movie Buff: Your Ultimate Movie Companion

Movie Buff is a Flutter app designed for movie enthusiasts who want quick access to information about popular and upcoming movies. Integrated with TheMovieDB.org's API, Movie Buff provides users with a seamless experience to discover, explore, and stay updated with their favorite movies.


## Features

- **Browse Popular Movies** : Get a list of the most popular movies currently trending.
- **Detailed Movie Information** : View detailed descriptions, release dates, and ratings for each movie.
- **Discover Upcoming Releases** : Stay ahead of the curve with upcoming movie releases and their details.
- **Search Functionality** : Easily search for any movie and access its information instantly.
- **State Management** : Utilizes Riverpod for state management.



## Installation
To get started with this project, follow these steps:

- Clone the repository to your local machine:

```bash
  git clone https://github.com/guptakaran11/Movie-Buff.git
```
- Navigate to the project directory.

```bash
  cd movie-buff
```
- Install dependencies using Flutter's package manager, pub.

```bash
  flutter pub get
```

- Run the app on your preferred device (emulator/simulator or physical device).

```bash
  flutter run
```


## Tech Stack

**Flutter:** The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

**Riverpod:** A state management library for Flutter that is easy to use, flexible, and designed to work with Flutter's devtools.

**REST API:**  Integration with TheMovieDB.org's API to fetch movie data.

**HTTP Package:**  A composable, multi-platform, Future-based API for HTTP requests.


## Contributing

Contributions are always welcome!

Feel free if you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request.

See `contributing.md` for ways to get started.

Please adhere to this project's `code of conduct`.


## API Reference

#### Get all items

```http
  GET https://api.themoviedb.org/3

```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get item

```http
  GET https://image.tmdb.org/t/p/original/${id}

```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |




![Logo](https://clipartcraft.com/images/m-logo-transparent-4.png)


## Demo

Link to demo video of the working of the app.

https://drive.google.com/file/d/1icz6UlJgY5yD3_HxL26lY6jnXiyAf-t9/view?usp=sharing
