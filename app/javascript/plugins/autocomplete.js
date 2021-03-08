const submitMovie = (event) => {
  const form = document.getElementById("new_search");
  const formInput = document.getElementById("search_query");
  const movieInput = document.getElementById("movie-input");
  // enter chosen movie in the search field
  movieInput.value = event.currentTarget.attributes["movie-title"].value;
  // set the value of the form field to the movie id
  formInput.value = event.currentTarget.attributes["movie-id"].value;
  form.submit();
};

const fetchMovies = (query) => {
  const movieSuggestions = document.getElementById("movie-suggestions");
  const tmdbKey = movieSuggestions.dataset.tmdbApiKey;
  fetch(
    `https://api.themoviedb.org/3/search/movie?api_key=${tmdbKey}&query=${query}`
  )
    .then((response) => response.json())
    .then(insertMovies);
};

const insertMovies = (data) => {
  const movieSuggestions = document.getElementById("movie-suggestions");
  movieSuggestions.innerHTML = "";
  const firstFour = data.results.slice(0, 4);
  firstFour.forEach((movie) => {
    const movieCard = `<div class="film-option" movie-id="${movie.id}" movie-title="${movie.original_title}">
                          <img src="https://image.tmdb.org/t/p/w200/${
                            movie.poster_path
                          }" alt="">
                          <p>${
                            movie.original_title
                          } (${movie.release_date.slice(0, 4)})</p>
                      </div>`;
    movieSuggestions.insertAdjacentHTML("beforeend", movieCard);
    const movieChoice = movieSuggestions.querySelectorAll(".film-option");
    movieChoice.forEach((movie) => {
      movie.addEventListener("click", submitMovie);
    });
  });
};

const initAutocomplete = () => {
  const movieInput = document.getElementById("movie-input");
  const movieSuggestions = document.getElementById("movie-suggestions");

  // added check for the presence of the element to suppress
  // errors on views without the movie input
  if (movieInput) {
    movieInput.addEventListener("keyup", (event) => {
      movieSuggestions.innerHTML = "";
      if (movieInput.value.length > 2) {
        fetchMovies(movieInput.value);
      }
    });
  }
};

export { initAutocomplete };
