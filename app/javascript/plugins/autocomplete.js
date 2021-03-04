// display movies in divs
// if you click a movie the form will be sent with movie id?
//
const movieInput = document.getElementById('search_query');
const movieSuggestions = document.getElementById('movie-suggestions');

const insertMovies = (data) => {
  console.log(data);
  const firstFour = data.results.slice(0,4);
  firstFour.forEach((movie) => {
    const title = `<p>${movie.original_title}</p>`;
    movieSuggestions.insertAdjacentHTML('beforeend', title);
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
