import React from "react";
// import { useState } from 'react'
import "../../assets/css/Categories/CategoriesMain.css";
import CategorySlider from "./CategorySlider";

//dumy data for testing
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
  {
    Title: "Inte som andra",
    Year: "2003",
    imdbID: "tt0268322",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYjA1ZWI3MmMtMTZhNC00MzFhLWE0MzktZDQ1MDZhMjkzZGJkXkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
  {
    Title: "Älskar älskar inte 2",
    Year: "1996",
    imdbID: "tt0115074",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BNGQ2ZTljZmItOThlNC00OWNlLTlhMjktYjVkMzk4MDhiNjZjXkEyXkFqcGc@._V1_SX300.jpg",
  },
  {
    Title: "Maria Wern: Inte ens det förflutna 2",
    Year: "2013",
    imdbID: "tt1736586",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMzY3NWRmNjAtYTRjOC00ZDdkLWE1YjktZDJjMTc2YzkyYmI2XkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
  {
    Title: "Jag är inte beredd att dö än 2",
    Year: "2015",
    imdbID: "tt4226373",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMTcxMDAzODUzOF5BMl5BanBnXkFtZTgwNzM0NzcyNDE@._V1_SX300.jpg",
  },
  {
    Title: "Farbrorn som inte vill va' stor 2",
    Year: "1980",
    imdbID: "tt0180354",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BZjM2N2MyNWUtM2UzMi00ODcxLWFmNDAtZmUwNjEzMGJkZTkyXkEyXkFqcGc@._V1_SX300.jpg",
  },
  {
    Title: "Allt jag inte minns 2",
    Year: "2020",
    imdbID: "tt9295359",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYmZlYzI5YTgtNWM4Yi00NTljLWFlMWUtNTJmN2U4ZmVhNDcwXkEyXkFqcGc@._V1_SX300.jpg",
  },
  {
    Title: "Och Piccadilly Circus ligger inte i Kumla 2",
    Year: "2015",
    imdbID: "tt3195371",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMTYwODg2MDg1Ml5BMl5BanBnXkFtZTgwMDI0NTA2MTE@._V1_SX300.jpg",
  },
  {
    Title: "Inte bara mördare 2",
    Year: "2001",
    imdbID: "tt0235486",
    Type: "movie",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BMTg5NTRjNjMtZjk4Yi00NjE4LTgyM2UtN2RiNWEyNTkwZmMwXkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
  {
    Title: "Vi är inte längre där - Sista åren med Kent 2",
    Year: "2017",
    imdbID: "tt6395199",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYTBmNzRjM2EtMjQzYi00NTMwLTk1NTgtZjlmNWEwYWI2ODMzL2ltYWdlXkEyXkFqcGdeQXVyNDYyMDY4MzU@._V1_SX300.jpg",
  },
  {
    Title: "Inte OK! 2",
    Year: "2015–",
    imdbID: "tt4220309",
    Type: "series",
    Poster:
      "https://m.media-amazon.com/images/M/MV5BYjI1M2ExYjQtZTQ5Ni00YWE5LTljOWMtZGI2ZjMzOTQ5MzJmXkEyXkFqcGdeQXVyMTQzMjU1NjE@._V1_SX300.jpg",
  },
];

//semulate the categories array
const categoriesArray = [
  {
    category: "Drama",
    description: "Popular TV with Arabic subtitles",
    movies: movies,
  },
];

function HomeCategories() {
  // for mohamed sameh => write the logic to get the categories from the server
  // =================||==============================||==============================
  // i am waiting for a response => [{},{},.... ] array of objects,
  // each object has a category name and an array of movies
  // =================||==============================||==============================
  // http://www.omdbapi.com/?apikey=[yourkey]&type=movie => response will be all movies, filterr it and store the imagesw of this response , (Poster)
  // i will reuse this logic in movies and series pages

  return categoriesArray.map((cat) => {
    return (
      <div className="category-slider" key={cat.category}>
        <CategorySlider data={cat} />
      </div>
    );
  });
}

export default HomeCategories;
