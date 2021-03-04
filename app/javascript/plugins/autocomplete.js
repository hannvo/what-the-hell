// display movies in divs
// if you click a movie the form will be sent with movie id?
//
const form = document.getElementById('new_search');
const movieInput = document.getElementById('search_query');
const movieSuggestions = document.getElementById('movie-suggestions');

const submitMovie = (event) => {
  console.log(form);
  // set the value of the form field to the movie id
  movieInput.value = event.currentTarget.attributes["movie-id"].value;
  form.submit();
}

const insertMovies = (data) => {
  const firstFour = data.results.slice(0,4);
  firstFour.forEach((movie) => {
    const movieCard = `<div class="film-option" movie-id="${movie.id}">
                          <img src="https://image.tmdb.org/t/p/w200/${movie.poster_path}" alt="">
                          <p>${movie.original_title} (${movie.release_date.slice(0,4)})</p>
                      </div>`;
    movieSuggestions.insertAdjacentHTML('beforeend', movieCard);
    const movieChoice = movieSuggestions.querySelectorAll('.film-option');
    movieChoice.forEach((movie) => {
      movie.addEventListener('click', submitMovie);
    });
 });
};

const fetchMovies = (query) => {
  const tmdbKey = movieSuggestions.dataset.tmdbApiKey
  fetch(`https://api.themoviedb.org/3/search/movie?api_key=${tmdbKey}&query=${query}`)
    .then(response => response.json())
    .then(insertMovies);
};

movieInput.addEventListener("keyup", (event) => {
  movieSuggestions.innerHTML = "";
  if (movieInput.value.length > 2) {
    fetchMovies(movieInput.value);
  };
});
