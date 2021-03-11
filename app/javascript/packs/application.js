// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import "controllers";
import { initAutocomplete } from "../plugins/autocomplete";
import { initMovieCable } from "../channels/movie_info_channel";
import { initFaceRecognitionCable } from "../channels/face_recognition_channel";
import { initMovieRecommendationCable } from "../channels/movie_recommendation_channel";
import { initCastCable } from "../channels/cast_channel";
import { initSlider } from "../plugins/swipe_slider";
import { initBiographyExpand } from "../plugins/biography_expand";
import { initScrollFast } from "../plugins/scroll_fast";

document.addEventListener("turbolinks:load", () => {
  // Call your functions here, e.g:
  // initSelect2();
  initMovieCable();
  initAutocomplete();
  initFaceRecognitionCable();
  initCastCable();
  initMovieRecommendationCable();
  // initSlider();
  initBiographyExpand();
  initScrollFast();
});
