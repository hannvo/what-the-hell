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

const movieImage = (movie) => {
  let img_url = "";
  if (movie.poster_path) {
    img_url = `https://image.tmdb.org/t/p/w500${movie.poster_path}`;
  } else {
    img_url = `https://dummyimage.com/40x60/000/fff.jpg&text=${movie.original_title}`;
  }
  return img_url;
};

const insertMovies = (data) => {
  const movieSuggestions = document.getElementById("movie-suggestions");
  movieSuggestions.innerHTML = "";
  const firstFour = data.results.slice(0, 4);
  firstFour.forEach((movie) => {
    const img_url = movieImage(movie);

    const movieCard = `<div class="film-option" movie-id="${
      movie.id
    }" movie-title="${movie.original_title}">
                          <img src="${img_url}" alt="">
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

const toggleElements = (input, suggestions, element) => {
  input.addEventListener("focus", (event) => {
    element.style.display = "none";
  });
  // if the input field loses focus and there are no movie suggestions on screen, restore the title
  input.addEventListener("blur", (event) => {
    if (suggestions.innerText == "") {
      element.style.display = "block";
    }
  });
};

const initAutocomplete = () => {
  const movieInput = document.getElementById("movie-input");
  const movieSuggestions = document.getElementById("movie-suggestions");
  const mainTitle = document.getElementsByClassName("main-title")[0];
  const movieCards = document.getElementById("movie-card-section");
  // added check for the presence of the element to suppress errors on views without the movie input
  if (movieInput) {
    if (mainTitle) {
      // add eventlistener to hide main title on input focus if it is present and restore it if needed
      toggleElements(movieInput, movieSuggestions, mainTitle);
    } else if (movieCards) {
      // hide and restore movie cards as needed
      toggleElements(movieInput, movieSuggestions, movieCards);
    }
    movieInput.addEventListener("keyup", (event) => {
      movieSuggestions.innerHTML = "";
      if (movieInput.value.length > 2) {
        fetchMovies(movieInput.value);
      }
    });
  }
};

export { initAutocomplete };
