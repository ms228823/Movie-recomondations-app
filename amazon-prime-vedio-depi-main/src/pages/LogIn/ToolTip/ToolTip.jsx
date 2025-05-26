import React, { useState } from "react";
import "../../../assets/css/LogIn/ToolTip/ToolTip.css"; 

const ToolTip = () => {
  const [visible, setVisible] = useState(false);

  return (
    <div className="tooltip-container">
      <label className="checkbox-label">
        <input class="keep-me-sign" type="checkbox" />
        Keep me signed in. 
        <span 
          className="details" 
          onMouseEnter={() => setVisible(true)} 
          onMouseLeave={() => setVisible(false)}
          onClick={() => setVisible(!visible)}
        >
          Details <i class="fa-solid fa-angle-down"></i>
        </span>
      </label>

      {visible && (
        <div className="tooltip-box">
          <p><strong>"Keep Me Signed In" Checkbox</strong></p>
          <p>
            Choosing "Keep me signed in" reduces the number of times you're asked to Sign-In on this device.
          </p>
          <p>
            To keep your account secure, use this option only on your personal devices.
          </p>
          <button className="close-btn" onClick={() => setVisible(false)}>✖</button>
        </div>
      )}
    </div>
  );
};

export default ToolTip;
