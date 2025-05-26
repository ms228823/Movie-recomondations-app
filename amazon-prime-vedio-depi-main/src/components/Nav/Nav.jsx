import "../../assets/css/Nav/Nav.css";
import { FaSearch, FaUserCircle, FaBookmark } from "react-icons/fa";
import { CgMenuGridO } from "react-icons/cg";
import { SiPrimevideo } from "react-icons/si";

import { useState } from "react";
import { useEffect } from "react";
import { useRef } from "react";
import { Routes, Route, Link } from "react-router-dom";

export default function Navbar() {
  const [menuOpen, setMenuOpen] = useState(false);
  const [myStuffOpen, setMyStuffOpen] = useState(false);
  const [isOpen, setIsOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);

  const [isLoggedIn, setIsLoggedIn] = useState(false);

  let menuRef = useRef();
  let userRef = useRef();
  let myStuffRef = useRef();
  let searchRef = useRef();
  const categoryTypes = [
    "Adventure",
    "Comedy",
    "Documentary",
    "Drama",
    "Horror",
    "Family",
    "Kids",
    "Mystery",
    "Thrillers",
    "Romance",
    "SciFi",
  ];
  const handleHover = () => {
    setIsOpen(true);
  };
  const handleClickOutsideMenu = (event) => {
    if (!menuRef.current.contains(event.target)) {
      setMenuOpen(false);
    }
  };
  const handleClickOutsideUser = (event) => {
    if (!userRef.current.contains(event.target)) {
      setIsOpen(false);
    }
  };
  const handleClickOutsideMyStuff = (event) => {
    if (!myStuffRef.current.contains(event.target)) {
      setMyStuffOpen(false);
    }
  };
  const handleClickOutsideSearch = (event) => {
    if (!searchRef.current.contains(event.target)) {
      setSearchOpen(false);
    }
  };
  const handleLogout = () => {
    localStorage.removeItem("user");
    setIsLoggedIn(false);
  };

  useEffect(() => {
    const user = localStorage.getItem("user");
    setIsLoggedIn(!!user);
  }, []);

  useEffect(() => {
    document.addEventListener("click", handleClickOutsideUser);
    document.addEventListener("click", handleClickOutsideMenu);
    document.addEventListener("click", handleClickOutsideMyStuff);
    document.addEventListener("click", handleClickOutsideSearch);
    return () => {
      document.removeEventListener("click", handleClickOutsideUser);
      document.removeEventListener("click", handleClickOutsideMenu);
      document.removeEventListener("click", handleClickOutsideMyStuff);
      document.removeEventListener("click", handleClickOutsideSearch);
    };
  }, []);

  useEffect(() => {
    let handler = (event) => {
      if (!menuRef.current.contains(event.target)) {
        setMenuOpen(true);
      }
    };
    document.addEventListener("mousedown", handler);

    return () => {
      document.removeEventListener("mousedown", handler);
    };
  });

  /*
  ================================
//   const [isOpen, setIsOpen] = useState(false);
//   const menuRef = useRef(null);
//   const handleHover = () => {setIsOpen(true);};
//   const handleClickOutside = (event) => {
    // if (menuRef.current && !menuRef.current.contains(event.target)) {
    //   setIsOpen(false);
    // }
//   };
//   useEffect(() => {
    // document.addEventListener("click", handleClickOutside);
    // return () => {
    //   document.removeEventListener("click", handleClickOutside);
    // };
//   }, []);
  return (
    <nav className="navbar">
      <div className="brand">Brand</div>
      <div className="menu-container" ref={menuRef}>
        <button className="menu-button" onMouseEnter={handleHover}>
          Menu
        </button>
        {isOpen && (
          <ul className="dropdown">
            <li>Option 1</li>
            <li>Option 2</li>
            <li>Option 3</li>
          </ul>
        )}
      </div>
    </nav>
  );
}
export default App;
=====================================
  */
  return (
    <div className="navbarContainer">
      <div className="navbarLogo">
        <a href="/">
          {/* <img src="../src/assets/prime.svg" alt="Prime Video Logo" className="navbarLogoImg"/> */}
          <SiPrimevideo className="navbarLogoIcon" />
        </a>
      </div>

      {/* Search and User Section */}
      <div className="navbarUserContainer">
        {isLoggedIn ? (
          <>
            <div className="navbarUserContainerBeforeAuth">
              <div
                className="navbarUserContainer"
                ref={userRef}
                onMouseEnter={handleHover}
              >
                <FaUserCircle className="navbarUserIcon" />
                {isOpen && (
                  <div
                    className="userMenu"
                    onMouseLeave={() => setIsOpen(false)}
                  >
                    <ul className="userMenuLst">
                      <DropdownItem text={"Sign in"} path="/LogIn" />
                      <DropdownItem text={"Register"} path="/SignUp" />
                    </ul>
                  </div>
                )}
              </div>
            </div>
          </>
        ) : (
          <>
            <div className="navbarLstContainer">
              <ul className="navbarLst">
                <li className=" navbarLstItem">
                  <Link
                    Link
                    to="/Homepage"
                    className="navbarLstLink navbarLstHome"
                  >
                    Home
                  </Link>
                </li>
                <li className="navbarLstItem">
                  <Link Link to="/Media/movies" className="navbarLstLink">
                    Movies
                  </Link>
                </li>
                <li className="navbarLstItem">
                  <Link Link to="/Media/tvshows" className="navbarLstLink">
                    TV Shows
                  </Link>
                </li>
              </ul>
            </div>
            <div className="navbarRightContainer">
              <div className="navSearchContainer" ref={searchRef}>
                <FaSearch
                  className="searchIcon"
                  onClick={() => setSearchOpen(!searchOpen)}
                />
                {searchOpen && (
                  <form action="" method="post">
                    <input
                      type="text"
                      placeholder="Search"
                      className="searchInput"
                    ></input>
                  </form>
                )}
              </div>
              <div className="navbarMenuContainer" ref={menuRef}>
                <CgMenuGridO
                  className="navbarMenuIcon"
                  onClick={() => setMenuOpen(!menuOpen)}
                />
                {menuOpen && (
                  <div
                    className={`navbarDropMenu ${
                      menuOpen ? "active" : "inactive"
                    }`}
                    //   onMouseLeave={() => setMenuOpen(false)}
                  >
                    <div>Genre</div>
                    <ul>
                      {categoryTypes.map((cat) => (
                        <DropdownItem
                          key={cat}
                          text={cat}
                          path={`/category/${cat}`}
                        />
                      ))}
                    </ul>
                  </div>
                )}
              </div>
              <div className="navbarMyStuff" ref={myStuffRef}>
                <FaBookmark
                  className="myStuffIcon"
                  onClick={() => setMyStuffOpen(!myStuffOpen)}
                />
                {myStuffOpen && (
                  <div
                    className="myStuffMenu"
                    //   onMouseLeave={() => setMyStuffOpen(false)}
                  >
                    <div>My Stuff</div>
                    <ul className="myStuffMenuLst">
                      <DropdownItem text={"All"} path="/MyStuff" />
                    </ul>
                  </div>
                )}
              </div>
              <div
                className="navbarUserContainer"
                ref={userRef}
                onMouseEnter={handleHover}
              >
                <FaUserCircle className="navbarUserIcon" />
                {isOpen && (
                  <div
                    className="userMenu"
                    // onMouseLeave={() => setIsOpen(false)}
                  >
                    <ul className="userMenuLst">
                      <DropdownItem
                        text={"Account Settings"}
                        path="/AccountAndSettings"
                      />
                      <DropdownItem
                        text={"Manage Profiles"}
                        path="/ManageAccounts"
                      />
                      <DropdownItem
                        onClick={handleLogout}
                        text={"Sign Out"}
                        path="/GuestPage"
                      />
                    </ul>
                  </div>
                )}
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

function DropdownItem(props) {
  return (
    <li>
      <Link to={props.path} className="navbar__link">
        {/* <a href="#" className="navbar__link"> */}
        <span>{props.text}</span>
        {/* </a> */}
      </Link>
    </li>
  );
}
