import React from "react";
import { useNavigate } from "react-router-dom";
import "../../assets/css/ManageAccounts/ManageAccounts.css";

const ManageAccounts = () => {
  const navigate = useNavigate();

  return (
    <div className="profile-selection-container">
      {/* Header Section */}
      <div className="logo">prime video</div>

      {/* Main Content */}
      <div className="main-content">
        <h1>Who's watching?</h1>
        <div className="profiles">
          {/* Adult Profile */}
          <div className="profile" onClick={() => navigate("/Homepage")}>
            <div className="avatar" style={{ backgroundColor: "#00A8E1" }}>
              <div className="default-avatar"></div>
            </div>
            <p>Adult</p>
          </div>

          {/* Kids Profile */}
          <div className="profile" onClick={() => navigate("/kidsAccount")}>
            <div className="avatar kids">
              <div className="kids-avatar">😊</div>
            </div>
            <p>Kids</p>
          </div>

          {/* Add New Profile */}
          <div className="profile" onClick={() => navigate("/addProfile")}>
            <div className="avatar add-new">
              <span>+</span>
            </div>
            <p>Add new</p>
          </div>
        </div>

        {/* Edit Profile Button */}
        <button className="edit-profile">Edit profile</button>
      </div>

      {/* Footer Section */}
      <footer>
        <div className="footer-links">
          <a href="#">Terms and Privacy Notice</a>
          <a href="#">Send us feedback</a>
          <a href="#">Help</a>
        </div>
        <p>© 1996-2025, Amazon.com, Inc. or its affiliates</p>
      </footer>
    </div>
  );
};

export default ManageAccounts;
