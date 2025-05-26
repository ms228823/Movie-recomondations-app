import React from "react";
import '../../assets/css/MyStuff/MyStuff.css';

const MyStuff = () => {
  return (
    <div className="myStuffPage">
      <div>
        <h1>My Stuff</h1>
      </div>
      <div>
        <h2>Watchlist</h2>
        <p>
          Your Wishlist is Empty, Add <a href="#">TV shows</a> and{" "}
          <a href="#">Movies</a> that you want to watch later by clicking Add to
          Watch list.
        </p>
      </div>
      <div>
        <h2>Pre-orders</h2>
        <p>
          You don't have any Pre-orders, If videos you were expecting aren't
          shown, make sure you're signed in and using the correct Amazon account
          and then <a href="#">refresh this page</a>.
        </p>
      </div>
    </div>
  );
};

export default MyStuff;
