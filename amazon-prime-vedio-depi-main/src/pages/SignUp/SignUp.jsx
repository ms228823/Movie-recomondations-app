import { useState, React } from "react";
import { Link,useNavigate } from "react-router-dom";
import "../../assets/css/SignUp/SignUp.css";
import LogInLogo from "../LogIn/LogInLogo/LogInLogo";
import LogInFooter from "../LogIn/LogInFooter/LogInFooter";
import axios from "axios";

function SignUp() {
  const [useEmail, setUseEmail] = useState(true);
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    name: "",
    phone: "",
    email: "",
    password: "",
  });
  const [errors, setErrors] = useState({});

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
    setErrors((prev) => ({
      ...prev,
      [name]: "",
    }));
  };

  const validate = () => {
    const newErrors = {};
    if (!formData.name.trim()) newErrors.name = "Enter your name";
  
    if (useEmail) {
      if (!formData.email.trim()) newErrors.email = "Enter your email";
    } else {
      if (!formData.phone.trim()) newErrors.phone = "Enter your phone number";
    }
  
    if (!formData.password.trim()) newErrors.password = "Enter your password";
  
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    const data = {
      name: formData.name,
      password: formData.password,
      email: useEmail ? formData.email : "", // if not using email, send empty
      phone: useEmail ? "" : formData.phone, // if using email, send empty
    };
  
    console.log("Sending data:", data); // 👈 Check this in the browser console
  
    if (!validate()) return;
    try {
      const response = await axios.post("http://127.0.0.1:5000/api/post/signup", {
        name: formData.name,
        email: formData.email,
        password: formData.password
      }, {
        headers: {
          "Content-Type": "application/json"
        },
        withCredentials: true
      });
  
      // console.log("Response:", response.data);
      console.log("Response from backend:", response.data);
  
      if (response.data.success) {
        alert(response.data.message); // Optional: show a success message
        navigate("/homepage");
      } else {
        alert(response.data.message || "Signup failed.");
      }
      
  
    } catch (error) {
      if (error.response) {
        console.error("Server responded with error:", error.response.data);
      } else {
        console.error("Request error:", error.message);
      }
      alert("An error occurred while logging in.");
    }
  };
  return (
    <>
    <div className="signup-main-container">
    <LogInLogo />
      <div className="signup-container">
        <div className="signup-box">
          <form onSubmit={handleSubmit}>
            <h2>Create Account</h2>
            <p className="required-text">All fields are required</p>

            <label className="input-label">Your name</label>
            {errors.name && <p className="error-text">{errors.name}</p>}
            <input
              type="text"
              name="name"
              placeholder="First and last name"
              className={`input-field ${errors.name ? "input-error" : ""}`}
              value={formData.name}
              onChange={handleInputChange}
            />

            <label className="input-label">
              {useEmail ? "Email" : "Mobile number"}
            </label>
            {useEmail && errors.email && (
              <p className="error-text">{errors.email}</p>
            )}
            {!useEmail && errors.phone && (
              <p className="error-text">{errors.phone}</p>
            )}
            <div className="mobile-input">
              {!useEmail ? (
                <>
                  <select className="country-code">
                    <option>EG +20</option>
                    <option>GB +44</option>
                    <option>US +1</option>
                    <option>IN +91</option>
                  </select>
                  <input
                    type="text"
                    name="phone"
                    placeholder="Mobile number"
                    className={`input-field ${errors.phone ? "input-error" : ""}`}
                    value={formData.phone}
                    onChange={handleInputChange}
                  />
                </>
              ) : (
                <input
                  type="email"
                  name="email"
                  placeholder="Enter your email"
                  className={`input-field ${errors.email ? "input-error" : ""}`}
                  value={formData.email}
                  onChange={handleInputChange}
                />
              )}
            </div>

            <a
              href="#"
              className="email-link"
              onClick={(e) => {
                e.preventDefault();
                setUseEmail(!useEmail);
              }}
            >
              {useEmail
                ? "Use your phone number instead"
                : "Use your email instead"}
              <i className="fa-solid fa-angle-right"></i>
            </a>

            <label className="input-label">Password</label>
            {errors.password && (
              <p className="error-text">{errors.password}</p>
            )}
            <input
              type="password"
              name="password"
              placeholder="At least 6 characters"
              className={`input-field ${errors.password ? "input-error" : ""}`}
              value={formData.password}
              onChange={handleInputChange}
            />
            <p className="password-info">
              <i className="fa-solid fa-circle-info"></i> Passwords must be at least
              6 characters.
            </p>

            <p className="verification-info">
              To verify your number, we will send you a text message with a
              temporary code. Message and data rates may apply.
            </p>

            <button className="continue-btn" type="submit">
              Create Account
            </button>
          </form>

          <div className="break_line"></div>

          <p className="signin-link">
            Already have an account?{" "}
            <Link to="/login">
              Sign in <i className="fa-solid fa-angle-right"></i>
            </Link>
          </p>
        </div>
      </div>
      <LogInFooter />
    </div>

    </>
  );
}

export default SignUp;
