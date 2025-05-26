import styled from "styled-components";

const StyledMainButton = styled.button`
  background: var(--primary-btn-background);
  background-origin: border-box;
  border-image: linear-gradient(
      90deg,
      hsla(0, 0%, 100%, 0) 10%,
      hsla(0, 0%, 100%, 0.3) 50%,
      hsla(0, 0%, 100%, 0) 90%
    )
    1/2px;
  border-image-width: 2px 0 0 0;
  box-shadow: 0 -4px 16px 0 rgba(var(--action-background-color, 255, 255, 255), 0.2);
  border-radius: 8px;
  outline: none;
  border: none;
  color: #fff;
  font-weight: bold;
  padding: 10px 20px;
  cursor: pointer;
  transition: background 0.3s ease;
  width: fit-content;

  &:hover {
    background: var(--bg-hover-color);
  }
`;
const StyledButton = styled.button`
  border: none;
  background-color: transparent;
  outline: none;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 4px;
`;

// use this component without specifying any type , that will give you the nav button styles

function Button({ children, onClick, type = "" }) {
  return type !== "primary" ? (
    <StyledMainButton onClick={onClick}>{children}</StyledMainButton>
  ) : (
    <StyledButton onClick={onClick}>{children}</StyledButton>
  );
}

export default Button;
