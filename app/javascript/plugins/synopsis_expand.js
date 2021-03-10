const show = (event) => {
  const synopsis = document.querySelector(".synopsis");
  synopsis.removeAttribute("hidden");
};

const poster = document.getElementById("reco-poster");
poster.addEventListener("click", show);
