import { ArrowLeftIcon, ArrowRightIcon } from "@heroicons/react/16/solid";
import { useSwiper } from "swiper/react";

function SliderNavigation({ isMouseEnter }) {
  const swiper = useSwiper();
  return (
    <>
      <div
        className={`button-next ${isMouseEnter ? "active" : ""}`}
        onClick={() => swiper.slideNext()}
      >
        <ArrowRightIcon width={20} color="white" />
      </div>
      <div
        className={`button-prev ${isMouseEnter ? "active" : ""}`}
        onClick={() => swiper.slidePrev()}
      >
        <ArrowLeftIcon width={20} color="white" />
      </div>
    </>
  );
}

export default SliderNavigation;
