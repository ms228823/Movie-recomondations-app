import styled from "styled-components";
// Import Swiper styles
import "swiper/css";

const Container = styled.div`
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  padding: 20px 10px;
  border-radius: 10px;
  position: relative;
  width: ${(props) => props.width || "100%"};
  height: ${(props) => props.height || "35vh"};
  margin: ${(props) => props.margin || "50px auto"};
`;

// When using this component, you have three custom properties you can set:
// 1. width: The width of the container (default is 100%).
// 2. height: The height of the container (default is 50vh).
// 3. margin: The margin around the container (default is 50px auto).

/** also note that this component give you the whole controle of the swiper component,
 *  just embed it as a child of this component and play with it as you want
 */
function SwiperSlider({
  onMouseEnter,
  onMouseLeave,
  children,
  width,
  height,
  margin,
}) {
  return (
    <Container
      className="swiper-container"
      onMouseEnter={onMouseEnter}
      onMouseLeave={onMouseLeave}
      width={width}
      height={height}
      margin={margin}
    >
      {/* this children will bwe the swiper component */}
      {children}
    </Container>
  );
}

export default SwiperSlider;
