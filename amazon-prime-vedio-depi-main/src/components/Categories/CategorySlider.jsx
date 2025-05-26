import "../../assets/css/Categories/CategorySlider.css";
import Button from "../UI/Button";
import MoviePopup from "../MoviesShowsComponent/MoviePopup";
import SliderNavigation from "./SliderNavigation";
import SwiperSlider from "../UI/SwiperSlider";

import { useNavigate } from "react-router-dom";
import { useState } from "react";

import { ArrowRightIcon } from "@heroicons/react/16/solid";

// Import Swiper styles
import "swiper/css";
import "swiper/css/navigation";
// import Swiper core and required modules
import { Navigation } from "swiper/modules";
import { Swiper, SwiperSlide } from "swiper/react";
import { useElementPosition } from "../../Hooks/useElementPosition";

function CategorySlider({ data }) {
  const [isMouseEnter, setIsMouseEnter] = useState(false);
  const navigate = useNavigate();
  const { screenWidth } = useElementPosition();

  return (
    <>
      <header>
        <h1 className="font-bold text-xl">{data.description}</h1>
        <Button
          type="primary"
          onClick={() => navigate(`/Category/${data.category}`)}
        >
          See More <ArrowRightIcon width={30} />
        </Button>
      </header>
      <SwiperSlider
        onMouseEnter={() => setIsMouseEnter(true)}
        onMouseLeave={() => setIsMouseEnter(false)}
        margin={"0"}
      >
        <Swiper
          modules={[Navigation]}
          spaceBetween={10}
          slidesPerView={
            screenWidth > 849
              ? 4
              : screenWidth <= 850 && screenWidth > 450
              ? 3
              : 1
          }
          navigation={false}
          loop={true}
          slidesPerGroup={3}
        >
          {data.movies.map((mv) => (
            <SwiperSlide key={mv.Title}>
              <MoviePopup movie={mv} />
            </SwiperSlide>
          ))}
          <SliderNavigation isMouseEnter={isMouseEnter} />
        </Swiper>
      </SwiperSlider>
    </>
  );
}

export default CategorySlider;
