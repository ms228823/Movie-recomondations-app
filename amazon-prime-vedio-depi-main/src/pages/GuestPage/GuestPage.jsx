import React from "react";
import { BrowserRouter as Router, Routes, Route, Link, Outlet } from "react-router-dom";
import '../../assets/fontawesome-free-6.6.0-web/css/all.css'
import '../../assets/css/GuestPage/GuestPage.css'
import Navbar from "../../components/Nav/Nav";
function GuestPage() {
    return (
        <>
        <Navbar />
        {/* <!-- first Content start --> */}
        <div className="content">
            <div className="text">
                <h2>Amazon Prime is now in Egypt</h2>
                <br /><br />
                <p>Join Amazon Prime to watch popular movies and TV shows, including award-winning Amazon Originals.
                    Amazon Prime also includes free and fast delivery on thousands of items and more.</p>
                <br /> <br />
                {/* <button><a href="#">Get Started</a></button> */}
                <button><Link to="/LogIn">Get Started</Link></button>
                <br /> <br />
                <h5>Subscribe to Amazon Prime for EGP 29/month or EGP 249/year.</h5>
            </div>
            <div className="image1">
                <img src="src\assets\images\GuestPage\MLP._SX1440_CR5750865675_QL80_AC_FP_.jpg" alt="First Photo" />
                
            </div>
        </div>
        {/* <!-- first Content End --> */}
        <br />
        {/* <!-- Second Content start --> */}
        <div className="content2">
            <div className="image2">
                <img src="src\assets\images\GuestPage\TVOD_MLP_Left._SX1440_CR00865675_QL80_AC_FP_.jpg" alt="Second Photo" />
            </div>
            <div className="text2">
                <h2>Great Entertainment</h2>
                <br /><br />
                <p>Watch Tom Clancy's Jack Ryan, award-winning Amazon Originals such as The Boys and The Marvelous Mrs.
                    Maisel, as well as popular movies and TV shows, with all titles available to download.</p>
                <br /> <br />
                <button><Link to="/LogIn">Get Started</Link></button>

                <br /> <br />
            </div>
        </div>
        {/* Second Content End */}

        {/* third Content start */}
        <div className="content3">
            <div className="photo1">
                <div className="pimg1"><img src="src\assets\images\GuestPage\pimg1.png" alt="" /></div>
                <h3>Watch anywhere</h3>
                <h5>Enjoy from the web or with the Prime Video app on your phone, tablet, or select Smart TVs — on up to
                    3 devices at once.</h5>
            </div>
            <div className="photo1">
                <div className="pimg2"><img src="src\assets\images\GuestPage\pimg2.png" alt="" /></div>
                <h3>X-Ray for more</h3>
                <h5>Use X-Ray for Movies and TV to identify actors and songs, explore actor bios, view trivia, and more.
                </h5>
            </div>
            <div className="photo1">
                <div className="pimg3"><img src="src\assets\images\GuestPage\pimg3.png" alt="" /></div>
                <h3>Data saver</h3>
                <h5>Control data usage while downloading and watching videos on select phones or tablets.</h5>
            </div>
        </div>
        {/* third Content END */}

        {/* Last Content Start */}
        <div className="content">
            <div className="text">
                <h2>Download and go</h2>
                <br /><br />
                <p>Watch offline on the Prime Video app when you download titles to your iPhone, iPad, Tablet, or
                    Android device.</p>
                <br /> <br />
                <button><Link to="/LogIn">Get Started</Link></button>

                <br /> <br />
            </div>
            <div className="image1">
                <img src="src\assets\images\GuestPage\last.jpeg" alt="First Photo" />
            </div>
        </div>
        {/* Last Content End */}
        <outlet />
        </>
    );
};
export default GuestPage;