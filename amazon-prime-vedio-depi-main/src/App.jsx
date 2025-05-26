import React from "react";
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Link,
  Outlet,
} from "react-router-dom";
import "./assets/css/App.css";
function App() {
  return (
    <>
      <Outlet />
    </>
  );
}

export default App;
