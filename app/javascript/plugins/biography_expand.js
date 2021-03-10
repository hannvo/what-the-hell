const expand = (event) => {
  // take the read more btn away
  event.currentTarget.remove();
  // show the whole bio
  const bio = document.getElementById('biography');
  bio.classList.add("full-bio");
  // turn gradient off
  const gradient = document.getElementById('bio-gradient');
  gradient.classList.remove("bio-gradient");
  // add show less button
  bio.insertAdjacentHTML('afterend', "<p class='btn-close-bio'>Show less</p>");
  const showLess = document.querySelector('.btn-close-bio');
  showLess.addEventListener('click', close);

}

const close = (event) => {
  const biography = document.getElementById('biography');
  // shrink bio
  biography.classList.remove("full-bio");
  // remove show less btn
  event.currentTarget.remove();
  // add read more button
  biography.insertAdjacentHTML('afterend', "<p id='btn-expand-bio'>Read more</p>");
  const showMore = document.getElementById('btn-expand-bio');
  showMore.addEventListener('click', expand);
  // turn gradient on
  const gradient = document.getElementById('bio-gradient');
  gradient.classList.add("bio-gradient");
}

const initBiographyExpand = () => {
  const bio = document.getElementById('biography');

  if (bio && bio.innerHTML.length > 200) {
    const gradient = document.getElementById('bio-gradient');
    gradient.classList.add("bio-gradient");
    bio.insertAdjacentHTML('afterend', "<p id='btn-expand-bio'>Read more</p>");
    const btnExpand = document.getElementById('btn-expand-bio');
    btnExpand.addEventListener("click", expand)};
};

export { initBiographyExpand };
