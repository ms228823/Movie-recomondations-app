// import { useEffect } from "react";
import { useEffect } from "react";
import { useState } from "react";

export function useElementPosition() {
  const [positionX, setPositinX] = useState(0);
  const [screenWidth, setScreenWidth] = useState(0);

  function getElementPosition(element) {
    setPositinX(element?.getBoundingClientRect().x);
  }

  useEffect(() => {
    let screenWidth = document.body.getBoundingClientRect().width;
    setScreenWidth(screenWidth);
  }, []);

  useEffect(() => {
    function handler(e) {
      e.target.innerWidth;
      setScreenWidth(e.target.innerWidth);
    }
    window.addEventListener("resize", handler);

    return () => {
      window.removeEventListener("resize", handler);
    };
  }, []);

  return { positionX, getElementPosition, screenWidth };
}
