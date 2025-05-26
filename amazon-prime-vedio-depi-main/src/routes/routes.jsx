import { createBrowserRouter } from "react-router-dom";
import App from "../App";
import LogIn from "../pages/LogIn/LogIn";
import SignUp from "../pages/SignUp/SignUp";
import AccountAndSettings from "../pages/AccountAndSettings/AccountAndSettings";
import Homepage from "../pages/Homepage/Homepage";
import KidsAccount from "../pages/KidsAccount/KidsAccount";
import ManageAccounts from "../pages/ManageAccounts/ManageAccounts";
import MyStuff from "../pages/MyStuff/MyStuff";
import ShowDetails from "../pages/ShowDetails/ShowDetails";
import Category from "../pages/Categories/Category";
// new
import GuestPage from "../pages/GuestPage/GuestPage";
import "../assets/fontawesome-free-6.6.0-web/css/all.css";
import Media from "../pages/Media/Media";

const router = createBrowserRouter([
  {
    path: "/",
    element: <App />,
    children: [
      {
        path: "LogIn",
        element: <LogIn />,
      },
      {
        path: "SignUp",
        element: <SignUp />,
      },
      {
        path: "AccountAndSettings",
        element: <AccountAndSettings />,
      },
      {
        path: "Category/:categoryType",
        element: <Category />,
      },
      {
        path: "media/:mediaShow",
        element: <Media />,
      },
      {
        path: "Homepage",
        element: <Homepage />,
      },
      {
        path: "KidsAccount",
        element: <KidsAccount />,
      },
      {
        path: "ManageAccounts",
        element: <ManageAccounts />,
      },
      {
        path: "MyStuff",
        element: <MyStuff />,
      },
      {
        path: "ShowDetails",
        element: <ShowDetails />,
      },
      {
        path: "GuestPage",
        element: <GuestPage />,
      },
      {
        path: "",
        element: <GuestPage />,  // changed from App to guestpage
      },
    ],
  },
]);

export default router;
