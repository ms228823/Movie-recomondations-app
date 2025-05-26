import React from "react";
import Carousel from "../../components/CarouselHome/Carousel";
// import { useState } from 'react'
import "../../assets/css/Homepage/Homepage.css";
import HomeCategories from "../../components/Categories/HomeCategories";
import Navbar from "../../components/Nav/Nav";
import Footer from "../../components/Footer/Footer";
function Homepage() {
  // return <HomeCategories />;
  return (
    <div>
      <Navbar />
      <Carousel />
      <HomeCategories />
      <Footer />
      {/* Other content */}
    </div>
  );
}

export default Homepage;
