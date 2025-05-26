import { useParams } from "react-router-dom";
import MoviePopup from "../../components/MoviesShowsComponent/MoviePopup";
import styled from "styled-components";
import DropList from "../../components/UI/DropList";

const movies = [
  {
    Title: "Om inte",
    Year: "2001",
    imdbID: "tt0268321",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYjA1ZWI3MmMtMTZhNC00MzFhLWE0MzktZDQ1MDZhMjkzZGJkXkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
  {
    Title: "Älskar älskar inte",
    Year: "1995",
    imdbID: "tt0115073",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BNGQ2ZTljZmItOThlNC00OWNlLTlhMjktYjVkMzk4MDhiNjZjXkEyXkFqcGc@._V1_SX300.jpg",
  },
  {
    Title: "Maria Wern: Inte ens det förflutna",
    Year: "2012",
    imdbID: "tt1736585",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMzY3NWRmNjAtYTRjOC00ZDdkLWE1YjktZDJjMTc2YzkyYmI2XkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
  {
    Title: "Jag är inte beredd att dö än",
    Year: "2014",
    imdbID: "tt4226372",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMTcxMDAzODUzOF5BMl5BanBnXkFtZTgwNzM0NzcyNDE@._V1_SX300.jpg",
  },
  {
    Title: "Farbrorn som inte vill va' stor",
    Year: "1979",
    imdbID: "tt0180353",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BZjM2N2MyNWUtM2UzMi00ODcxLWFmNDAtZmUwNjEzMGJkZTkyXkEyXkFqcGc@._V1_SX300.jpg",
  },
  {
    Title: "Allt jag inte minns",
    Year: "2019",
    imdbID: "tt9295358",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYmZlYzI5YTgtNWM4Yi00NTljLWFlMWUtNTJmN2U4ZmVhNDcwXkEyXkFqcGc@._V1_SX300.jpg",
  },
  {
    Title: "Och Piccadilly Circus ligger inte i Kumla",
    Year: "2014",
    imdbID: "tt3195370",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMTYwODg2MDg1Ml5BMl5BanBnXkFtZTgwMDI0NTA2MTE@._V1_SX300.jpg",
  },
  {
    Title: "Inte bara mördare",
    Year: "2000",
    imdbID: "tt0235485",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMTg5NTRjNjMtZjk4Yi00NjE4LTgyM2UtN2RiNWEyNTkwZmMwXkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
  {
    Title: "Vi är inte längre där - Sista åren med Kent",
    Year: "2016",
    imdbID: "tt6395198",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYTBmNzRjM2EtMjQzYi00NTMwLTk1NTgtZjlmNWEwYWI2ODMzL2ltYWdlXkEyXkFqcGdeQXVyNDYyMDY4MzU@._V1_SX300.jpg",
  },
  {
    Title: "Inte OK!",
    Year: "2014–",
    imdbID: "tt4220308",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYjI1M2ExYjQtZTQ5Ni00YWE5LTljOWMtZGI2ZjMzOTQ5MzJmXkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
];
const StyledCategoryContainer = styled.div`
  padding: 0 15px;

  header {
    display: flex;
    flex-direction: column;
    gap: 15px;
    align-items: start;
    h2 {
      text-transform: capitalize;
    }
  }
`;
const Main = styled.main`
  display: flex;
  flex-wrap: wrap;
  gap: 20px 10px;
`;
function Category() {
  const { categoryType } = useParams();
  return (
    <StyledCategoryContainer>
      <header>
        <h2>{categoryType}</h2>
        <DropList
          listItems={["movies", "Series"]}
          bgcolor={"var(--bg-color-lighter)"}
        />
      </header>
      <Main className="justify-center md:justify-start">
        {movies.map((mv) => (
          <MoviePopup
            movie={mv}
            key={mv.imdbID}
            withinslider={false}
            width="w-[45%] md:w-[30%] lg:w-[24%]"
            height="h-[35vh] lg:h-[32vh]"
          />
        ))}
      </Main>
    </StyledCategoryContainer>
  );
}

export default Category;
