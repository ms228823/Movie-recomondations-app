import styled from "styled-components";
import "../../assets/css/MoviesShowsComponent/MoviePopup.css";
import {
  CheckIcon,
  NoSymbolIcon,
  PlayIcon,
  PlusIcon,
} from "@heroicons/react/16/solid";
import { TextWrapper } from "../../utils/textWrapper";
import { useElementPosition } from "../../Hooks/useElementPosition";
import { useRef } from "react";
const StyledMoviePopup = styled.div`
  height: ${(props) => props.withinslider === "true" && "100%"};
  width: ${(props) => props.withinslider === "true" && "100%"};
  overflow: visible;
  position: relative;
  transform-style: preserve-3d;
  z-index: 10;

  .movie-details {
    display: none;
    flex-direction: column;
    align-items: start;
    gap: 10px;
    border-radius: 0 0 var(--border-radius) var(--border-radius);
    margin-top: -10px;
    padding: 10px 15px;
    box-shadow: 10 0 10px rgba(0, 0, 0, 0.5);
    background-color: var(--primary-bg-color);
    .play-btn {
      width: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 5px;
      background-color: var(--bg-color-lighter);
      padding: 8px 0;
      border-radius: var(--border-radius);
      cursor: pointer;
    }
    .play-btn:hover {
      background-color: #fff;
      color: var(--bg-color-lighter);
    }
    .action-btns {
      display: flex;
      gap: 10px;
      justify-content: center;
      :hover {
        background-color: #fff;
        color: var(--bg-color-lighter);
      }
      * {
        border-radius: 100%;
        background-color: var(--bg-color-lighter);
        padding: 10px;
        cursor: pointer;
      }
    }

    span {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 5px;

      svg {
        background-color: #19d7f0;
        padding: 2px;
        color: white;
        border-radius: 100%;
      }
    }
    .info {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 10px;
      span {
        background-color: var(--bg-color-lighter);
        border-radius: var(--border-radius);
        padding: 4px 6px;
        font-weight: 600;
      }
    }
    p {
      text-align: start;
    }
  }
  &:hover {
    z-index: 999;
    isolation: isolate;
    transform: ${(props) =>
      props.position < 9
        ? "scale(1.1) translateX(7px)"
        : props.position < 15
        ? "translateX(20px) scale(1.2)"
        : props.position > 710 && props.position < 1060
        ? "translateX(-10px) scale(1.2)"
        : "scale(1.2) translateX(0px)"};
    border-radius: var(--border-radius) var(--border-radius) 0 0;
    transition: 0.2s ease;
    & .movie-details {
      display: flex;
    }
  }
  img {
    width: 100%;
    height: 100%;
    border-radius: var(--border-radius);
    cursor: pointer;
  }
`;
function MoviePopup({ movie, withinslider = "true", width, height }) {
  const movieRef = useRef(null);
  const { positionX, getElementPosition } = useElementPosition();

  // Movie popup that will be shown within tha CategorySlider
  return (
    <StyledMoviePopup
      className={`movie-popup ${width} ${withinslider !== "true" && height} `}
      withinslider={withinslider}
      height={height}
      ref={movieRef}
      onMouseEnter={() => getElementPosition(movieRef.current)}
      position={positionX}
    >
      <img src={movie.Poster} alt={`${movie.Title} cover photo`} />
      <div className={`movie-details`}>
        <h3 className="text-[15px] lg:text-[18px] font-bold">{movie.Title}</h3>
        <div className="play-btn">
          <PlayIcon width={25} /> Play
        </div>
        <div className="action-btns">
          <PlusIcon width={40} /> <NoSymbolIcon width={40} />
        </div>
        <span className=" text-[10px] md:text-[16px]">
          <CheckIcon className="w-3 md:w-4" /> included with prime
        </span>
        <div className="info text-[13px]">
          <p className="hidden md:block">{movie.Year}</p> 1h 35 min
          <span>+16</span>
        </div>
        <p className="hidden md:block">
          {TextWrapper(`
          Lorem, ipsum dolor sit amet consectetur adipisicing elit. Harum
          officia velit dicta at doloribus minima adipisci, a suscipit
          reprehenderit animi explicabo eligendi nesciunt ratione tenetur
          repellat impedit dolore qui quisquam veritatis magnam error et. Neque
          modi earum illo accusamus doloremque!
          `)}
        </p>
      </div>
    </StyledMoviePopup>
  );
}

export default MoviePopup;
