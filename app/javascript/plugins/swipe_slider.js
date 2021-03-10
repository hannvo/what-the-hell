import Swipe from "swipejs";

const initSlider = () => {
  const slider = document.getElementById("slider");
  if (slider) {
    window.mySwipe = new Swipe(slider, {
      startSlide: 0,
      auto: 3000,
      draggable: false,
      autoRestart: false,
      continuous: true,
      disableScroll: true,
      stopPropagation: true,
      callback: function (index, slider) {},
      transitionEnd: function (index, slider) {},
    });
  }
};

export { initSlider };
